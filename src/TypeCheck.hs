module TypeCheck (typeCheckProgram) where

import qualified Data.Map as M
import qualified Control.Monad
import Data.Maybe (fromMaybe)
import Data.Functor.Identity (Identity)
import Control.Monad.State (StateT, get, put, gets, modify)

import AbsSimplego
import Exception

type TypeEnv = M.Map String Type
type TIO a = StateT TypeEnv IO a

find :: String -> TIO Type
find name = gets (fromMaybe (throwType ("undefined variable " ++ name)) . M.lookup name)

declare :: String -> Type -> TIO ()
declare name t = Control.Monad.void (modify (M.insert name t))

declareArgs :: [Arg] -> TIO ()
declareArgs = mapM_ (\ (Arg (Ident name) t) -> declare name (VarType t))

typesFromArgs :: [Arg] -> [VarType]
typesFromArgs = map (\ (Arg _ t) -> t)

inLocalEnv :: TIO () -> TIO ()
inLocalEnv m = do
    oldEnv <- get
    m
    put oldEnv

typeCheckProgram :: Program -> TIO ()
typeCheckProgram (Program topDefs) = do
    let env = foldl insertIdent M.empty topDefs
    put env
    mapM_ typeCheckFn topDefs
    where
        insertIdent :: M.Map String Type -> TopDef -> M.Map String Type
        insertIdent e (FnDef (Ident name) args returnType _) =
            M.insert name (VarType (TFun (typesFromArgs args) returnType)) e

typeCheckFn :: TopDef -> TIO ()
typeCheckFn (FnDef _ args returnType block) = inLocalEnv $ do
        declareArgs args
        typeCheckStmt (BlockStmt block) returnType

typeCheckStmt :: Stmt -> Type -> TIO ()
typeCheckStmt (SimpleStmt stmt) _ = typeCheckSimpleStmt stmt
typeCheckStmt (ReturnStmt MaybeExprNo) returnType =
    if returnType == TVoid
    then return ()
    else throwType "expected function to return value"
typeCheckStmt (ReturnStmt (MaybeExprYes e)) returnType = expectExprType returnType e
typeCheckStmt BreakStmt _ = return ()
typeCheckStmt ContinueStmt _ = return ()
typeCheckStmt (PrintStmt e) _ = do
    t <- typeCheckExpr e
    case t of
        VarType TInt -> return ()
        VarType TBool -> return ()
        VarType TFun{} -> throwType "cannot print functions"
        TVoid -> throwType "cannot print void values"
typeCheckStmt (BlockStmt (Block [])) _ = return ()
typeCheckStmt (BlockStmt (Block (x : xs))) returnType = inLocalEnv $ do
    typeCheckStmt x returnType
    typeCheckStmt (BlockStmt (Block xs)) returnType
typeCheckStmt (IfStmt (If e block maybeElse)) returnType = do
    expectExprVarType TBool e
    typeCheckStmt (BlockStmt block) returnType
    typeCheckMaybeElse maybeElse returnType
typeCheckStmt (ForStmt clause block) returnType = inLocalEnv $ do
    typeCheckForClause clause
    typeCheckStmt (BlockStmt block) returnType

typeCheckSimpleStmt :: SimpleStmt -> TIO ()
typeCheckSimpleStmt EmptySimpleStmt = return ()
typeCheckSimpleStmt (ExprSimpleStmt e) = Control.Monad.void (typeCheckExpr e)
typeCheckSimpleStmt (AssSimpleStmt (Ass (Ident name) e)) = do
    expectedType <- find name
    expectExprType expectedType e
typeCheckSimpleStmt (AssSimpleStmt (AssOp ident _ e)) = do
    expectExprVarType TInt (EVar ident)
    expectExprVarType TInt e
typeCheckSimpleStmt (AssSimpleStmt (Incr ident)) =
    typeCheckSimpleStmt (AssSimpleStmt (AssOp ident AddAss (ELitInt 1)))
typeCheckSimpleStmt (AssSimpleStmt (Decr ident)) =
    typeCheckSimpleStmt (AssSimpleStmt (AssOp ident SubAss (ELitInt 1)))
typeCheckSimpleStmt (DeclSimpleStmt (Ident name) expectedType NoInit) =
    declare name (VarType expectedType)
typeCheckSimpleStmt (DeclSimpleStmt (Ident name) expectedType (Init e)) = do
    expectExprVarType expectedType e
    declare name (VarType expectedType)
typeCheckSimpleStmt (ShortDeclSimpleStmt (Ident name) e) = do
    t <- typeCheckExpr e
    declare name t

typeCheckExpr :: Expr -> TIO Type
typeCheckExpr (EVar (Ident name)) = find name
typeCheckExpr (ELitInt _) = return (VarType TInt)
typeCheckExpr (EFun args returnType block) = do
    oldEnv <- get
    declareArgs args
    typeCheckStmt (BlockStmt block) returnType
    put oldEnv
    return (VarType (TFun (typesFromArgs args) returnType))
typeCheckExpr ELitTrue = return (VarType TBool)
typeCheckExpr ELitFalse = return (VarType TBool)
typeCheckExpr (EApp e args) = do
    t <- typeCheckExpr e
    appliedArgTypes <- mapM typeCheckExpr args
    let appliedArgVarTypes = map varTypeFromType appliedArgTypes
    case t of
        VarType (TFun argTypes returnType) ->
            if argTypes == appliedArgVarTypes
                then return returnType
                else throwType "invalid types applied to function"
        _ -> throwType "tried to call not a function"
    where
        varTypeFromType :: Type -> VarType
        varTypeFromType TVoid = throwType "unexpected void value"
        varTypeFromType (VarType t) = t

typeCheckExpr (ENeg e) = do
    expectExprVarType TInt e
    return (VarType TInt)
typeCheckExpr (ENot e) = do
    expectExprVarType TBool e
    return (VarType TBool)
typeCheckExpr (EMul e1 _ e2) = do
    expectExprVarType TInt e1
    expectExprVarType TInt e2
    return (VarType TInt)
typeCheckExpr (EAdd e1 _ e2) = typeCheckExpr (EMul e1 TimesOp e2)
typeCheckExpr (ERel e1 _ e2) = do
    expectExprVarType TInt e1
    expectExprVarType TInt e2
    return (VarType TBool)
typeCheckExpr (EAnd e1 e2) = do
    expectExprVarType TBool e1
    expectExprVarType TBool e2
    return (VarType TBool)
typeCheckExpr (EOr e1 e2) = typeCheckExpr (EAnd e1 e2)

expectExprType :: Type -> Expr -> TIO ()
expectExprType expectedType e = do
    t <- typeCheckExpr e
    if t == expectedType then return () else throwType "expected different type"

expectExprVarType :: VarType -> Expr -> TIO ()
expectExprVarType t = expectExprType (VarType t)

typeCheckMaybeElse :: MaybeElse -> Type -> TIO ()
typeCheckMaybeElse NoElse _ = return ()
typeCheckMaybeElse (Else (IfOfIfOrBlock ifStmt)) returnType =
    typeCheckStmt (IfStmt ifStmt) returnType
typeCheckMaybeElse (Else (BlockOfIfOrBlock block)) returnType =
    typeCheckStmt (BlockStmt block) returnType

typeCheckForClause :: ForClause -> TIO ()
typeCheckForClause (ForCond cond) = typeCheckForCond cond
typeCheckForClause (ForFull preStmt cond postStmt) = do
    typeCheckStmt (SimpleStmt preStmt) TVoid
    typeCheckForCond cond
    typeCheckStmt (SimpleStmt postStmt) TVoid

typeCheckForCond :: Condition -> TIO ()
typeCheckForCond (ExprCond e) = Control.Monad.void (typeCheckExpr e)
typeCheckForCond TrueCond = return ()
