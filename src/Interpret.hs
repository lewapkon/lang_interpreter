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

data StoreObject
    = OInt Integer
    | OBool Bool
    | OFun Env [Arg LineCol] (Type LineCol) (Block LineCol)
    | OVoid
    deriving (Show, Eq)

data StmtResult
    = Returned StoreObject
    | Broken LineCol
    | Continued LineCol
    | Normal deriving (Eq)

type Loc = Int
type Env = M.Map Ident Loc
type Store = M.Map Loc StoreObject
type State = (Env, Store)
type SIO a = StateT State IO a

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

getLoc :: Ident -> LineCol -> SIO Loc
getLoc ident@(Ident name) loc = do
    e <- getEnv
    return $ fromMaybe (throwRuntime (name ++ " is undefined") loc) (M.lookup ident e)

getVariable :: Ident -> LineCol -> SIO StoreObject
getVariable ident loc = do
    l <- getLoc ident loc
    s <- getStore
    return $ fromJust $ M.lookup l s

declareVariable :: Ident -> StoreObject -> SIO ()
declareVariable ident obj = do
    l <- alloc
    modifyEnv (M.insert ident l)
    modifyStore (M.insert l obj)

assignVariable :: Ident -> LineCol -> StoreObject -> SIO ()
assignVariable ident loc obj = do
    l <- getLoc ident loc
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
        insertIdent (e, i) (FnDef _ ident _ _ _) = (M.insert ident i e, i + 1)

        addTopDef (FnDef _ ident args returnType block) = do
            e <- getEnv
            let l = fromJust $ M.lookup ident e
            modifyStore $ M.insert l $ OFun e args returnType block

        runMain = eval $ EApp Nothing (EVar Nothing (Ident "main")) []

interpret :: Stmt LineCol -> SIO StmtResult
interpret (SimpleStmt _ stmt) = do
    interpretSimpleStmt stmt
    return Normal

interpret (ReturnStmt _ MaybeExprNo{}) = return $ Returned OVoid
interpret (ReturnStmt _ (MaybeExprYes _ e)) = do
    v <- eval e
    return $ Returned v

interpret (BreakStmt loc) = return (Broken loc)

interpret (ContinueStmt loc) = return (Continued loc)

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
    let forFull = ForFull Nothing (EmptySimpleStmt Nothing) cond (EmptySimpleStmt Nothing)
    in interpret (ForStmt Nothing forFull block)
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
        Broken _ -> return Normal
        Returned v -> return $ Returned v
        _ ->
            let forStmt = ForStmt Nothing (ForFull Nothing (EmptySimpleStmt Nothing) cond postStmt) block
            in interpret $ BlockStmt Nothing $ Block Nothing [SimpleStmt Nothing postStmt, forStmt])
    else return Normal

evalCondition :: Condition LineCol -> SIO Bool
evalCondition TrueCond{} = return True
evalCondition (ExprCond _ e) = do
    v <- eval e
    case v of OBool b -> return b

interpretMaybeElse :: MaybeElse LineCol -> SIO StmtResult
interpretMaybeElse NoElse{} = return Normal
interpretMaybeElse (Else _ (BlockOfIfOrBlock _ block)) = interpret $ BlockStmt Nothing block
interpretMaybeElse (Else _ (IfOfIfOrBlock _ ifStmt)) = interpret $ IfStmt Nothing ifStmt

interpretSimpleStmt :: SimpleStmt LineCol -> SIO ()
interpretSimpleStmt EmptySimpleStmt{} = return ()

interpretSimpleStmt (ExprSimpleStmt _ e) = Control.Monad.void $ eval e

interpretSimpleStmt (AssSimpleStmt _ stmt) = Control.Monad.void $ interpretAssStmt stmt

interpretSimpleStmt (DeclSimpleStmt _ ident declType NoInit{}) =
    interpretSimpleStmt $ DeclSimpleStmt Nothing ident declType $ Init Nothing $ init declType
    where init TInt{} = ELitInt Nothing 0
          init TBool{} = ELitFalse Nothing
          init (TFun _ argTypes returnType) =
            EFun Nothing (map (Arg Nothing (Ident "")) argTypes) returnType $ Block Nothing []
interpretSimpleStmt (DeclSimpleStmt _ ident _ (Init _ e)) = do
    v <- eval e
    declareVariable ident v

interpretSimpleStmt (ShortDeclSimpleStmt _ ident e) = do
    v <- eval e
    declareVariable ident v

interpretAssStmt :: AssStmt LineCol -> SIO ()
interpretAssStmt (Ass loc ident e) = assignVariable ident loc =<< eval e
interpretAssStmt (Incr _ ident) = interpretAssStmt $ AssOp Nothing ident (AddAss Nothing) $ ELitInt Nothing 1
interpretAssStmt (Decr _ ident) = interpretAssStmt $ AssOp Nothing ident (SubAss Nothing) $ ELitInt Nothing 1
interpretAssStmt (AssOp loc ident op e2) = do
    OInt n <- eval (mapOp op)
    interpretAssStmt $ Ass Nothing ident $ ELitInt Nothing n
    where e1 = EVar loc ident
          mapOp (AddAss loc2) = EAdd loc e1 (PlusOp loc2) e2
          mapOp (SubAss loc2) = EAdd loc e1 (MinusOp loc2) e2
          mapOp (MulAss loc2) = EMul loc e1 (TimesOp loc2) e2
          mapOp (DivAss loc2) = EMul loc e1 (DivOp loc2) e2
          mapOp (ModAss loc2) = EMul loc e1 (ModOp loc2) e2

eval :: Expr LineCol -> SIO StoreObject
eval (EVar loc ident) = getVariable ident loc
eval (ELitInt _ n) = return (OInt n)
eval (EFun _ args returnType block) = do
    e <- getEnv
    return $ OFun e args returnType block
eval ELitTrue{} = return $ OBool True
eval ELitFalse{} = return $ OBool False
eval (EApp loc fExpr exprs) = do
    fun <- eval fExpr
    case fun of
        OFun env args returnType block -> do
            oldEnv <- getEnv
            vals <- mapM eval exprs
            modifyEnv (const env)
            mapM_ (\ (Arg _ ident _, value) -> declareVariable ident value) (zip args vals)
            res <- interpret $ BlockStmt Nothing block
            modifyEnv (const oldEnv)
            case res of
                Returned v -> return v
                Normal -> return $ defaultValue returnType
                Broken loc -> throwRuntime "break is not in a loop" loc
                Continued loc -> throwRuntime "continue is not in a loop" loc
        _ -> throwRuntime ("cannot call " ++ show fExpr) loc
    where defaultValue (VarType _ TInt{}) = OInt 0
          defaultValue (VarType _ TBool{}) = OBool False
          defaultValue (VarType _ (TFun _ argTypes returnType)) =
              OFun M.empty (map (Arg Nothing (Ident "")) argTypes) returnType $ Block Nothing []
          defaultValue TVoid{} = OVoid
eval (ENeg _ e) = do
    v <- eval e
    return $ case v of
        OInt n -> OInt $ -n
eval (ENot _ e) = do
    v <- eval e
    return $ case v of
        OBool b -> OBool $ not b
eval (EMul loc e1 op e2) = do
    v1 <- eval e1
    v2 <- eval e2
    mapOp op (intFromObject v1) (intFromObject v2)
    where mapOp TimesOp{} x y = return $ OInt $ x * y
          mapOp DivOp{} _ 0 = throwRuntime "cannot divide by zero" loc
          mapOp DivOp{} x y = return $ OInt $ x `div` y
          mapOp ModOp{} _ 0 = throwRuntime "cannot mod by zero" loc
          mapOp ModOp{} x y = return $ OInt $ x `mod` y
eval (EAdd _ e1 op e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OInt $ mapOp op (intFromObject v1) (intFromObject v2)
    where mapOp PlusOp{} = (+)
          mapOp MinusOp{} = (-)
eval (ERel _ e1 op e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OBool $ mapOp op (intFromObject v1) (intFromObject v2)
    where mapOp LTOp{} = (<)
          mapOp LEOp{} = (<=)
          mapOp GTOp{} = (>)
          mapOp GEOp{} = (>=)
          mapOp EQOp{} = (==)
          mapOp NEOp{} = (/=)
eval (EAnd _ e1 e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OBool $ boolFromObject v1 && boolFromObject v2
eval (EOr _ e1 e2) = do
    v1 <- eval e1
    v2 <- eval e2
    return $ OBool $ boolFromObject v1 || boolFromObject v2
