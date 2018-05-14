{-# LANGUAGE LambdaCase #-}

module Interpret where

import qualified Data.Map as M
import Data.Maybe (Maybe, fromMaybe, fromJust)
import Data.List (length)
import Control.Arrow
import qualified Control.Monad
import Control.Monad.State (StateT, get, put, gets, modify, liftIO)

import AbsSimplego
import Common
import Exception

type Loc = Int
type Env = M.Map String Loc
data StoreObject = OInt Integer | OBool Bool | OFun Env [Arg LineCol] (Type LineCol) (Block LineCol) | OVoid deriving (Show, Eq)
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

execProgram :: Program LineCol -> SIO ()
execProgram (Program _ topDefs) = do
    modifyEnv $ const $ fst $ foldl insertIdent (M.empty, 0) topDefs
    mapM_ addTopDef topDefs
    runMain
    return ()
    where
        insertIdent (e, i) (FnDef _ (Ident name) _ _ _) = (M.insert name i e, i + 1)

        addTopDef (FnDef _ (Ident name) args returnType block) = do
            e <- getEnv
            let l = fromJust $ M.lookup name e
            modifyStore $ M.insert l $ OFun e args returnType block

        runMain = eval $ EApp Nothing (EVar Nothing (Ident "main")) []

interpret :: Stmt LineCol -> SIO StmtResult
interpret (SimpleStmt _ stmt) = do
    interpretSimpleStmt stmt
    return Normal

interpret (ReturnStmt _ (MaybeExprNo _)) = return $ Returned OVoid
interpret (ReturnStmt _ (MaybeExprYes _ e)) = do
    v <- eval e
    return $ Returned v

interpret (BreakStmt _) = return Broken

interpret (ContinueStmt _) = return Continued

interpret (PrintStmt _ e) = do
    v <- eval e
    liftIO $ putStrLn $ case v of
        OInt n -> show n
        OBool b -> show b
    return Normal

interpret (BlockStmt _ (Block _ [])) = return Normal
interpret (BlockStmt _ (Block _ (x : xs))) = do
    res <- interpret x
    if res == Normal
    then interpret $ BlockStmt Nothing $ Block Nothing xs
    else return res

interpret (IfStmt _ (If _ e block maybeElse)) = do
    v <- eval e
    case v of
        OBool b ->
            if b then interpret (BlockStmt Nothing block)
            else interpretMaybeElse maybeElse

interpret (ForStmt _ (ForCond _ cond) block) =
    interpret (ForStmt Nothing (ForFull Nothing (EmptySimpleStmt Nothing) cond (EmptySimpleStmt Nothing)) block)
interpret (ForStmt _ (ForFull _ preStmt cond postStmt) block) = do
    e <- getEnv
    interpretSimpleStmt preStmt
    res <- runFor cond postStmt block
    modifyEnv $ const e
    return res

runFor :: Condition LineCol -> SimpleStmt LineCol -> Block LineCol -> SIO StmtResult
runFor cond postStmt block = do
    b <- evalCondition cond
    if b then interpret (BlockStmt Nothing block) >>= (\ case
        Broken -> return Normal
        Returned v -> return $ Returned v
        _ -> interpret $ BlockStmt Nothing $ Block Nothing [SimpleStmt Nothing postStmt, ForStmt Nothing (ForFull Nothing (EmptySimpleStmt Nothing) cond postStmt) block])
    else return Normal

evalCondition :: Condition LineCol -> SIO Bool
evalCondition (TrueCond _) = return True
evalCondition (ExprCond _ e) = do
    v <- eval e
    case v of OBool b -> return b

interpretMaybeElse :: MaybeElse LineCol -> SIO StmtResult
interpretMaybeElse (NoElse _) = return Normal
interpretMaybeElse (Else Nothing (BlockOfIfOrBlock Nothing block)) = interpret $ BlockStmt Nothing block
interpretMaybeElse (Else Nothing (IfOfIfOrBlock Nothing ifStmt)) = interpret $ IfStmt Nothing ifStmt

interpretSimpleStmt :: SimpleStmt LineCol -> SIO ()
interpretSimpleStmt (EmptySimpleStmt _) = return ()

interpretSimpleStmt (ExprSimpleStmt _ e) = Control.Monad.void $ eval e

interpretSimpleStmt (AssSimpleStmt _ stmt) = Control.Monad.void $ interpretAssStmt stmt

interpretSimpleStmt (DeclSimpleStmt _ (Ident name) declType (NoInit _)) =
    interpretSimpleStmt $ DeclSimpleStmt Nothing (Ident name) declType $ Init Nothing $ init declType
    where init (TInt _) = ELitInt Nothing 0
          init (TBool _) = ELitFalse Nothing
          init (TFun _ argTypes returnType) = EFun Nothing (map (Arg Nothing (Ident "")) argTypes) returnType $ Block Nothing []
interpretSimpleStmt (DeclSimpleStmt _ (Ident name) _ (Init _ e)) = do
    v <- eval e
    declareVariable name v

interpretSimpleStmt (ShortDeclSimpleStmt _ (Ident name) e) = do
    v <- eval e
    declareVariable name v

interpretAssStmt :: AssStmt LineCol -> SIO ()
interpretAssStmt (Ass _ (Ident name) e) = assignVariable name =<< eval e
interpretAssStmt (Incr _ (Ident name)) = interpretAssStmt $ AssOp Nothing (Ident name) (AddAss Nothing) $ ELitInt Nothing 1
interpretAssStmt (Decr _ (Ident name)) = interpretAssStmt $ AssOp Nothing (Ident name) (SubAss Nothing) $ ELitInt Nothing 1
interpretAssStmt (AssOp _ (Ident name) op e) = do
    v1 <- getVariable name
    v2 <- eval e
    case (v1, v2) of (OInt n1, OInt n2) -> interpretAssStmt $ Ass Nothing (Ident name) $ ELitInt Nothing $ mapOp op n1 n2
    where mapOp (AddAss _) = (+)
          mapOp (SubAss _) = (-)
          mapOp (MulAss _) = (*)
          mapOp (DivAss _) = div
          mapOp (ModAss _) = mod

eval :: Expr LineCol -> SIO StoreObject
eval (EVar _ (Ident name)) = getVariable name
eval (ELitInt _ n) = return (OInt n)
eval (EFun _ args returnType block) = do
    e <- getEnv
    return $ OFun e args returnType block
eval (ELitTrue _) = return $ OBool True
eval (ELitFalse _) = return $ OBool False
eval (EApp _ fExpr exprs) = do
    fun <- eval fExpr
    case fun of
        OFun env args returnType block -> do
            oldEnv <- getEnv
            vals <- mapM eval exprs
            modifyEnv (const env)
            mapM_ (\ (Arg _ (Ident argName) _, value) -> declareVariable argName value) (zip args vals)
            res <- interpret $ BlockStmt Nothing block
            modifyEnv (const oldEnv)
            case res of
                Returned v -> return v
                Normal -> return $ defaultValue returnType
                Broken -> throwRuntime "break is not in a loop"
                Continued -> throwRuntime "continue is not in a loop"
        _ -> throwRuntime ("cannot call " ++ show fExpr)
    where defaultValue (VarType _ (TInt _)) = OInt 0
          defaultValue (VarType _ (TBool _)) = OBool False
          defaultValue (VarType _ (TFun _ argTypes returnType)) =
              OFun M.empty (map (Arg Nothing (Ident "")) argTypes) returnType (Block Nothing [])
          defaultValue (TVoid _) = OVoid
eval (ENeg _ e) = do
    v <- eval e
    return $ case v of
        OInt n -> OInt $ -n
eval (ENot _ e) = do
    v <- eval e
    return $ case v of
        OBool b -> OBool $ not b
eval (EMul _ e1 op e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OInt $ mapOp op (intFromObject v1) (intFromObject v2)
    where mapOp (TimesOp _) = (*)
          mapOp (DivOp _) = div
          mapOp (ModOp _) = mod
eval (EAdd _ e1 op e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OInt $ mapOp op (intFromObject v1) (intFromObject v2)
    where mapOp (PlusOp _) = (+)
          mapOp (MinusOp _) = (-)
eval (ERel _ e1 op e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OBool $ mapOp op (intFromObject v1) (intFromObject v2)
    where mapOp (LTOp _) = (<)
          mapOp (LEOp _) = (<=)
          mapOp (GTOp _) = (>)
          mapOp (GEOp _) = (>=)
          mapOp (EQOp _) = (==)
          mapOp (NEOp _) = (/=)
eval (EAnd _ e1 e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OBool $ boolFromObject v1 && boolFromObject v2
eval (EOr _ e1 e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OBool $ boolFromObject v1 || boolFromObject v2
