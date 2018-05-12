{-# LANGUAGE LambdaCase #-}

module Interpret where

import qualified Data.Map as M
import Data.Maybe (fromMaybe, fromJust)
import Data.List (length)
import Control.Arrow
import qualified Control.Monad
import Control.Monad.State (StateT, get, put, gets, modify, liftIO)

import AbsSimplego
import Exception

type Loc = Int
type Env = M.Map String Loc
data StoreObject = OInt Integer | OBool Bool | OFun Env [Arg] Type Block | OVoid deriving (Show, Eq)
type Store = M.Map Loc StoreObject
type State = (Env, Store)
type SIO a = StateT State IO a

data StmtResult = Returned StoreObject | Broken | Continued | Normal deriving (Eq)

alloc :: SIO Loc
alloc = do
    s <- getStore
    if M.null s then return 0
    else let (i, _) = M.findMax s in return $ i + 1

getEnv :: SIO Env
getEnv = gets fst

modifyEnv :: (Env -> Env) -> SIO ()
modifyEnv f = modify $ Control.Arrow.first f

getStore :: SIO Store
getStore = gets snd

modifyStore :: (Store -> Store) -> SIO ()
modifyStore f = modify $ Control.Arrow.second f

getLoc :: String -> SIO Loc
getLoc name = do
    e <- getEnv
    return $ fromMaybe (throwRuntime (name ++ " is undefined")) (M.lookup name e)

getVariable :: String -> SIO StoreObject
getVariable name = do
    l <- getLoc name
    s <- getStore
    return $ fromJust $ M.lookup l s

declareVariable :: String -> StoreObject -> SIO ()
declareVariable name obj = do
    l <- alloc
    modifyEnv (M.insert name l)
    modifyStore (M.insert l obj)

assignVariable :: String -> StoreObject -> SIO ()
assignVariable name obj = do
    l <- getLoc name
    modifyStore (M.insert l obj)

intFromObject :: StoreObject -> Integer
intFromObject (OInt n) = n

boolFromObject :: StoreObject -> Bool
boolFromObject (OBool b) = b

execProgram :: Program -> SIO ()
execProgram (Program topDefs) = do
    modifyEnv $ const $ fst $ foldl insertIdent (M.empty, 0) topDefs
    mapM_ addTopDef topDefs
    runMain
    return ()
    where
        insertIdent (e, i) (FnDef (Ident name) _ _ _) = (M.insert name i e, i + 1)

        addTopDef (FnDef (Ident name) args returnType block) = do
            e <- getEnv
            let l = fromJust $ M.lookup name e
            modifyStore $ M.insert l $ OFun e args returnType block

        runMain = eval $ EApp (EVar (Ident "main")) []

interpret :: Stmt -> SIO StmtResult
interpret (SimpleStmt stmt) = do
    interpretSimpleStmt stmt
    return Normal

interpret (ReturnStmt MaybeExprNo) = return $ Returned OVoid
interpret (ReturnStmt (MaybeExprYes e)) = do
    v <- eval e
    return $ Returned v

interpret BreakStmt = return Broken

interpret ContinueStmt = return Continued

interpret (PrintStmt e) = do
    v <- eval e
    liftIO $ putStrLn $ case v of
        OInt n -> show n
        OBool b -> show b
    return Normal

interpret (BlockStmt (Block [])) = return Normal
interpret (BlockStmt (Block (x : xs))) = do
    res <- interpret x
    if res == Normal
    then interpret $ BlockStmt $ Block xs
    else return res

interpret (IfStmt (If e block maybeElse)) = do
    v <- eval e
    case v of
        OBool b ->
            if b then interpret (BlockStmt block)
            else interpretMaybeElse maybeElse

interpret (ForStmt (ForCond cond) block) =
    interpret (ForStmt (ForFull EmptySimpleStmt cond EmptySimpleStmt) block)
interpret (ForStmt (ForFull preStmt cond postStmt) block) = do
    e <- getEnv
    interpretSimpleStmt preStmt
    res <- runFor cond postStmt block
    modifyEnv $ const e
    return res

runFor :: Condition -> SimpleStmt -> Block -> SIO StmtResult
runFor cond postStmt block = do
    b <- evalCondition cond
    if b then interpret (BlockStmt block) >>= (\ case
        Broken -> return Normal
        Returned v -> return $ Returned v
        _ -> interpret $ BlockStmt $ Block [SimpleStmt postStmt, ForStmt (ForFull EmptySimpleStmt cond postStmt) block])
    else return Normal

evalCondition :: Condition -> SIO Bool
evalCondition TrueCond = return True
evalCondition (ExprCond e) = do
    v <- eval e
    case v of OBool b -> return b

interpretMaybeElse :: MaybeElse -> SIO StmtResult
interpretMaybeElse NoElse = return Normal
interpretMaybeElse (Else (BlockOfIfOrBlock block)) = interpret $ BlockStmt block
interpretMaybeElse (Else (IfOfIfOrBlock ifStmt)) = interpret $ IfStmt ifStmt

interpretSimpleStmt :: SimpleStmt -> SIO ()
interpretSimpleStmt EmptySimpleStmt = return ()

interpretSimpleStmt (ExprSimpleStmt e) = Control.Monad.void $ eval e

interpretSimpleStmt (AssSimpleStmt stmt) = Control.Monad.void $ interpretAssStmt stmt

interpretSimpleStmt (DeclSimpleStmt (Ident name) declType NoInit) =
    interpretSimpleStmt $ DeclSimpleStmt (Ident name) declType $ Init $ init declType
    where init TInt = ELitInt 0
          init TBool = ELitFalse
          init (TFun argTypes returnType) = EFun (map (Arg (Ident "")) argTypes) returnType $ Block []
interpretSimpleStmt (DeclSimpleStmt (Ident name) _ (Init e)) = do
    v <- eval e
    declareVariable name v

interpretSimpleStmt (ShortDeclSimpleStmt (Ident name) e) = do
    v <- eval e
    declareVariable name v

interpretAssStmt :: AssStmt -> SIO ()
interpretAssStmt (Ass (Ident name) e) = assignVariable name =<< eval e
interpretAssStmt (Incr (Ident name)) = interpretAssStmt $ AssOp (Ident name) AddAss $ ELitInt 1
interpretAssStmt (Decr (Ident name)) = interpretAssStmt $ AssOp (Ident name) SubAss $ ELitInt 1
interpretAssStmt (AssOp (Ident name) op e) = do
    v1 <- getVariable name
    v2 <- eval e
    case (v1, v2) of (OInt n1, OInt n2) -> interpretAssStmt $ Ass (Ident name) $ ELitInt $ mapOp op n1 n2
    where mapOp AddAss = (+)
          mapOp SubAss = (-)
          mapOp MulAss = (*)
          mapOp DivAss = div
          mapOp ModAss = mod

eval :: Expr -> SIO StoreObject
eval (EVar (Ident name)) = getVariable name
eval (ELitInt n) = return (OInt n)
eval (EFun args returnType block) = do
    e <- getEnv
    return $ OFun e args returnType block
eval ELitTrue = return $ OBool True
eval ELitFalse = return $ OBool False
eval (EApp fExpr exprs) = do
    fun <- eval fExpr
    case fun of
        OFun env args returnType block -> do
            oldEnv <- getEnv
            vals <- mapM eval exprs
            modifyEnv (const env)
            mapM_ (\ (Arg (Ident argName) _, value) -> declareVariable argName value) (zip args vals)
            res <- interpret $ BlockStmt block
            modifyEnv (const oldEnv)
            case res of
                Returned v -> return v
                Normal -> return $ defaultValue returnType
                Broken -> throwRuntime "break is not in a loop"
                Continued -> throwRuntime "continue is not in a loop"
        _ -> throwRuntime ("cannot call " ++ show fExpr)
    where defaultValue (VarType TInt) = OInt 0
          defaultValue (VarType TBool) = OBool False
          defaultValue (VarType (TFun argTypes returnType)) =
              OFun M.empty (map (Arg (Ident "")) argTypes) returnType (Block [])
          defaultValue TVoid = OVoid
eval (ENeg e) = do
    v <- eval e
    return $ case v of
        OInt n -> OInt $ -n
eval (ENot e) = do
    v <- eval e
    return $ case v of
        OBool b -> OBool $ not b
eval (EMul e1 op e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OInt $ mapOp op (intFromObject v1) (intFromObject v2)
    where mapOp TimesOp = (*)
          mapOp DivOp = div
          mapOp ModOp = mod
eval (EAdd e1 op e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OInt $ mapOp op (intFromObject v1) (intFromObject v2)
    where mapOp PlusOp = (+)
          mapOp MinusOp = (-)
eval (ERel e1 op e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OBool $ mapOp op (intFromObject v1) (intFromObject v2)
    where mapOp LTOp = (<)
          mapOp LEOp = (<=)
          mapOp GTOp = (>)
          mapOp GEOp = (>=)
          mapOp EQOp = (==)
          mapOp NEOp = (/=)
eval (EAnd e1 e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OBool $ boolFromObject v1 && boolFromObject v2
eval (EOr e1 e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OBool $ boolFromObject v1 || boolFromObject v2
