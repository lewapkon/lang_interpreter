module TypeCheck (typeCheckProgram) where

import qualified Data.Map as M
import qualified Control.Monad
import Data.Maybe (fromMaybe)
import Data.Functor.Identity (Identity)
import Control.Monad.State (StateT, get, put, gets, modify)

import AbsSimplego
import Common
import Exception

type TypeEnv = M.Map Ident (Type LineCol)
type TIO a = StateT TypeEnv IO a

find :: Ident -> LineCol -> TIO (Type LineCol)
find ident@(Ident name) loc = gets (fromMaybe (throwType ("undefined variable " ++ name) loc) . M.lookup ident)

declare :: Ident -> Type LineCol -> TIO ()
declare ident t = Control.Monad.void (modify (M.insert ident t))

declareArgs :: [Arg LineCol] -> TIO ()
declareArgs = mapM_ (\ (Arg _ ident t) -> declare ident (VarType Nothing t))

typesFromArgs :: [Arg LineCol] -> [VarType LineCol]
typesFromArgs = map (\ (Arg _ _ t) -> t)

inLocalEnv :: TIO () -> TIO ()
inLocalEnv m = do
    oldEnv <- get
    m
    put oldEnv

locFromType :: Type LineCol -> LineCol
locFromType (TVoid loc) = loc
locFromType (VarType loc _) = loc

typeCheckProgram :: Program LineCol -> TIO ()
typeCheckProgram (Program _ topDefs) = do
    let env = foldl insertIdent M.empty topDefs
    put env
    mapM_ typeCheckFn topDefs
    where
        insertIdent :: TypeEnv -> TopDef LineCol -> TypeEnv
        insertIdent e (FnDef _ ident args returnType _) =
            M.insert ident (VarType Nothing (TFun Nothing (typesFromArgs args) returnType)) e

typeCheckFn :: TopDef LineCol -> TIO ()
typeCheckFn (FnDef _ _ args returnType block) = inLocalEnv $ do
        declareArgs args
        typeCheckStmt (BlockStmt Nothing block) returnType

typeCheckStmt :: Stmt LineCol -> Type LineCol -> TIO ()
typeCheckStmt (SimpleStmt _ stmt) _ = typeCheckSimpleStmt stmt
typeCheckStmt (ReturnStmt loc MaybeExprNo{}) returnType =
    case returnType of
        TVoid _ -> return ()
        _ -> throwType "expected function to return value" loc
typeCheckStmt (ReturnStmt _ (MaybeExprYes _ e)) returnType = expectExprType returnType e
typeCheckStmt BreakStmt{} _ = return ()
typeCheckStmt ContinueStmt{} _ = return ()
typeCheckStmt (PrintStmt loc e) _ = do
    t <- typeCheckExpr e
    case t of
        VarType _ TInt{} -> return ()
        VarType _ TBool{} -> return ()
        VarType _ TFun{} -> throwType "cannot print functions" loc
        TVoid{} -> throwType "cannot print void values" loc
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
typeCheckSimpleStmt (AssSimpleStmt _ (Ass loc ident e)) = do
    expectedType <- find ident loc
    expectExprType expectedType e
typeCheckSimpleStmt (AssSimpleStmt _ (AssOp _ ident _ e)) = do
    expectExprVarType (TInt Nothing) (EVar Nothing ident)
    expectExprVarType (TInt Nothing) e
typeCheckSimpleStmt (AssSimpleStmt _ (Incr _ ident)) =
    typeCheckSimpleStmt (AssSimpleStmt Nothing (AssOp Nothing ident (AddAss Nothing) (ELitInt Nothing 1)))
typeCheckSimpleStmt (AssSimpleStmt _ (Decr _ ident)) =
    typeCheckSimpleStmt (AssSimpleStmt Nothing (AssOp Nothing ident (SubAss Nothing) (ELitInt Nothing 1)))
typeCheckSimpleStmt (DeclSimpleStmt _ ident expectedType NoInit{}) =
    declare ident (VarType Nothing expectedType)
typeCheckSimpleStmt (DeclSimpleStmt _ ident expectedType (Init _ e)) = do
    expectExprVarType expectedType e
    declare ident (VarType Nothing expectedType)
typeCheckSimpleStmt (ShortDeclSimpleStmt _ ident e) = do
    t <- typeCheckExpr e
    declare ident t

typeCheckExpr :: Expr LineCol -> TIO (Type LineCol)
typeCheckExpr (EVar loc ident) = find ident loc
typeCheckExpr (ELitInt loc _) = return (VarType loc (TInt loc))
typeCheckExpr (EFun loc args returnType block) = do
    oldEnv <- get
    declareArgs args
    typeCheckStmt (BlockStmt loc block) returnType
    put oldEnv
    return (VarType loc (TFun loc (typesFromArgs args) returnType))
typeCheckExpr (ELitTrue loc) = return (VarType loc (TBool loc))
typeCheckExpr (ELitFalse loc) = return (VarType loc (TBool loc))
typeCheckExpr (EApp loc e args) = do
    t <- typeCheckExpr e
    appliedArgTypes <- mapM typeCheckExpr args
    let appliedArgVarTypes = map varTypeFromType appliedArgTypes
    case t of
        VarType _ (TFun _ argTypes returnType) ->
            if length argTypes == length appliedArgVarTypes
                then if argTypes == appliedArgVarTypes
                    then return returnType
                    else throwType "invalid types applied to function" loc
                else throwType "invalid number of arguments passed to function" loc
        _ -> throwType "tried to call not a function" loc
    where
        varTypeFromType :: Type LineCol -> VarType LineCol
        varTypeFromType (TVoid loc) = throwType "unexpected void value" loc
        varTypeFromType (VarType _ t) = t
typeCheckExpr (ENeg loc e) = do
    expectExprVarType (TInt Nothing) e
    return (VarType loc (TInt loc))
typeCheckExpr (ENot loc e) = do
    expectExprVarType (TBool Nothing) e
    return (VarType loc (TBool loc))
typeCheckExpr (EMul loc e1 _ e2) = do
    expectExprVarType (TInt Nothing) e1
    expectExprVarType (TInt Nothing) e2
    return (VarType loc (TInt loc))
typeCheckExpr (EAdd loc e1 _ e2) = typeCheckExpr (EMul loc e1 (TimesOp loc) e2)
typeCheckExpr (ERel loc e1 _ e2) = do
    expectExprVarType (TInt Nothing) e1
    expectExprVarType (TInt Nothing) e2
    return (VarType loc (TBool loc))
typeCheckExpr (EAnd loc e1 e2) = do
    expectExprVarType (TBool Nothing) e1
    expectExprVarType (TBool Nothing) e2
    return (VarType loc (TBool loc))
typeCheckExpr (EOr loc e1 e2) = typeCheckExpr (EAnd loc e1 e2)

expectExprType :: Type LineCol -> Expr LineCol -> TIO ()
expectExprType expectedType e = do
    t <- typeCheckExpr e
    let loc = locFromType t
    if t == expectedType then return () else throwType "expected different type" loc

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
