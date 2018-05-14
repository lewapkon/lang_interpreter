module TypeCheck (typeCheckProgram) where

import qualified Data.Map as M
import qualified Control.Monad
import Data.Maybe (fromMaybe)
import Data.Functor.Identity (Identity)
import Control.Monad.State (StateT, get, put, gets, modify)

import AbsSimplego
import Common
import Exception

type TypeEnv = M.Map String (Type LineCol)
type TIO a = StateT TypeEnv IO a

find :: String -> TIO (Type LineCol)
find name = gets (fromMaybe (throwType ("undefined variable " ++ name)) . M.lookup name)

declare :: String -> Type LineCol -> TIO ()
declare name t = Control.Monad.void (modify (M.insert name t))

declareArgs :: [Arg LineCol] -> TIO ()
declareArgs = mapM_ (\ (Arg _ (Ident name) t) -> declare name (VarType Nothing t))

typesFromArgs :: [Arg LineCol] -> [VarType LineCol]
typesFromArgs = map (\ (Arg _ _ t) -> t)

inLocalEnv :: TIO () -> TIO ()
inLocalEnv m = do
    oldEnv <- get
    m
    put oldEnv

typeCheckProgram :: Program LineCol -> TIO ()
typeCheckProgram (Program _ topDefs) = do
    let env = foldl insertIdent M.empty topDefs
    put env
    mapM_ typeCheckFn topDefs
    where
        insertIdent :: M.Map String (Type LineCol) -> TopDef LineCol -> M.Map String (Type LineCol)
        insertIdent e (FnDef _ (Ident name) args returnType _) =
            M.insert name (VarType Nothing (TFun Nothing (typesFromArgs args) returnType)) e

typeCheckFn :: TopDef LineCol -> TIO ()
typeCheckFn (FnDef _ _ args returnType block) = inLocalEnv $ do
        declareArgs args
        typeCheckStmt (BlockStmt Nothing block) returnType

typeCheckStmt :: Stmt LineCol -> Type LineCol -> TIO ()
typeCheckStmt (SimpleStmt _ stmt) _ = typeCheckSimpleStmt stmt
typeCheckStmt (ReturnStmt _ MaybeExprNo{}) returnType =
    case returnType of
        TVoid _ -> return ()
        _ -> throwType "expected function to return value"
typeCheckStmt (ReturnStmt _ (MaybeExprYes _ e)) returnType = expectExprType returnType e
typeCheckStmt BreakStmt{} _ = return ()
typeCheckStmt ContinueStmt{} _ = return ()
typeCheckStmt (PrintStmt _ e) _ = do
    t <- typeCheckExpr e
    case t of
        VarType _ TInt{} -> return ()
        VarType _ TBool{} -> return ()
        VarType _ TFun{} -> throwType "cannot print functions"
        TVoid{} -> throwType "cannot print void values"
typeCheckStmt (BlockStmt _ (Block _ [])) _ = return ()
typeCheckStmt (BlockStmt _ (Block _ (x : xs))) returnType = inLocalEnv $ do
    typeCheckStmt x returnType
    typeCheckStmt (BlockStmt Nothing (Block Nothing xs)) returnType
typeCheckStmt (IfStmt _ (If _ e block maybeElse)) returnType = do
    expectExprVarType (TBool Nothing) e
    typeCheckStmt (BlockStmt Nothing block) returnType
    typeCheckMaybeElse maybeElse returnType
typeCheckStmt (ForStmt _ clause block) returnType = inLocalEnv $ do
    typeCheckForClause clause
    typeCheckStmt (BlockStmt Nothing block) returnType

typeCheckSimpleStmt :: SimpleStmt LineCol -> TIO ()
typeCheckSimpleStmt (EmptySimpleStmt _) = return ()
typeCheckSimpleStmt (ExprSimpleStmt _ e) = Control.Monad.void (typeCheckExpr e)
typeCheckSimpleStmt (AssSimpleStmt _ (Ass _ (Ident name) e)) = do
    expectedType <- find name
    expectExprType expectedType e
typeCheckSimpleStmt (AssSimpleStmt _ (AssOp _ ident _ e)) = do
    expectExprVarType (TInt Nothing) (EVar Nothing ident)
    expectExprVarType (TInt Nothing) e
typeCheckSimpleStmt (AssSimpleStmt _ (Incr _ ident)) =
    typeCheckSimpleStmt (AssSimpleStmt Nothing (AssOp Nothing ident (AddAss Nothing) (ELitInt Nothing 1)))
typeCheckSimpleStmt (AssSimpleStmt _ (Decr _ ident)) =
    typeCheckSimpleStmt (AssSimpleStmt Nothing (AssOp Nothing ident (SubAss Nothing) (ELitInt Nothing 1)))
typeCheckSimpleStmt (DeclSimpleStmt _ (Ident name) expectedType NoInit{}) =
    declare name (VarType Nothing expectedType)
typeCheckSimpleStmt (DeclSimpleStmt _ (Ident name) expectedType (Init _ e)) = do
    expectExprVarType expectedType e
    declare name (VarType Nothing expectedType)
typeCheckSimpleStmt (ShortDeclSimpleStmt _ (Ident name) e) = do
    t <- typeCheckExpr e
    declare name t

typeCheckExpr :: Expr LineCol -> TIO (Type LineCol)
typeCheckExpr (EVar _ (Ident name)) = find name
typeCheckExpr (ELitInt _ _) = return (VarType Nothing (TInt Nothing))
typeCheckExpr (EFun _ args returnType block) = do
    oldEnv <- get
    declareArgs args
    typeCheckStmt (BlockStmt Nothing block) returnType
    put oldEnv
    return (VarType Nothing (TFun Nothing (typesFromArgs args) returnType))
typeCheckExpr ELitTrue{} = return (VarType Nothing (TBool Nothing))
typeCheckExpr ELitFalse{} = return (VarType Nothing (TBool Nothing))
typeCheckExpr (EApp _ e args) = do
    t <- typeCheckExpr e
    appliedArgTypes <- mapM typeCheckExpr args
    let appliedArgVarTypes = map varTypeFromType appliedArgTypes
    case t of
        VarType _ (TFun _ argTypes returnType) ->
            if argTypes == appliedArgVarTypes
                then return returnType
                else throwType "invalid types applied to function"
        _ -> throwType "tried to call not a function"
    where
        varTypeFromType :: Type LineCol -> VarType LineCol
        varTypeFromType TVoid{} = throwType "unexpected void value"
        varTypeFromType (VarType _ t) = t

typeCheckExpr (ENeg _ e) = do
    expectExprVarType (TInt Nothing) e
    return (VarType Nothing (TInt Nothing))
typeCheckExpr (ENot _ e) = do
    expectExprVarType (TBool Nothing) e
    return (VarType Nothing (TBool Nothing))
typeCheckExpr (EMul _ e1 _ e2) = do
    expectExprVarType (TInt Nothing) e1
    expectExprVarType (TInt Nothing) e2
    return (VarType Nothing (TInt Nothing))
typeCheckExpr (EAdd _ e1 _ e2) = typeCheckExpr (EMul Nothing e1 (TimesOp Nothing) e2)
typeCheckExpr (ERel _ e1 _ e2) = do
    expectExprVarType (TInt Nothing) e1
    expectExprVarType (TInt Nothing) e2
    return (VarType Nothing (TBool Nothing))
typeCheckExpr (EAnd _ e1 e2) = do
    expectExprVarType (TBool Nothing) e1
    expectExprVarType (TBool Nothing) e2
    return (VarType Nothing (TBool Nothing))
typeCheckExpr (EOr _ e1 e2) = typeCheckExpr (EAnd Nothing e1 e2)

expectExprType :: Type LineCol -> Expr LineCol -> TIO ()
expectExprType expectedType e = do
    t <- typeCheckExpr e
    if t == expectedType then return () else throwType "expected different type"

expectExprVarType :: VarType LineCol -> Expr LineCol -> TIO ()
expectExprVarType t = expectExprType (VarType Nothing t)

typeCheckMaybeElse :: MaybeElse LineCol -> Type LineCol -> TIO ()
typeCheckMaybeElse NoElse{} _ = return ()
typeCheckMaybeElse (Else _ (IfOfIfOrBlock _ ifStmt)) returnType =
    typeCheckStmt (IfStmt Nothing ifStmt) returnType
typeCheckMaybeElse (Else _ (BlockOfIfOrBlock _ block)) returnType =
    typeCheckStmt (BlockStmt Nothing block) returnType

typeCheckForClause :: ForClause LineCol -> TIO ()
typeCheckForClause (ForCond _ cond) = typeCheckForCond cond
typeCheckForClause (ForFull _ preStmt cond postStmt) = do
    typeCheckStmt (SimpleStmt Nothing preStmt) (TVoid Nothing)
    typeCheckForCond cond
    typeCheckStmt (SimpleStmt Nothing postStmt) (TVoid Nothing)

typeCheckForCond :: Condition LineCol -> TIO ()
typeCheckForCond (ExprCond _ e) = Control.Monad.void (typeCheckExpr e)
typeCheckForCond TrueCond{} = return ()
