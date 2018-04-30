module Interpreter where

import qualified Data.Map as M
import Control.Monad.Reader (ReaderT, ask, runReaderT)
import Control.Monad.State (StateT, get, put, gets, modify, execStateT, evalState)
import Control.Exception (Exception)

import AbsSimplego
import LexSimplego
import ParSimplego

type Loc = Int
type Env = M.Map String Loc
type Store = M.Map Loc Int
type RSIO a = ReaderT Env (StateT Env IO)

alloc :: Store -> Loc
alloc m = if M.null m then 0
          else let (i, w) = M.findMax m in i + 1

alloc' :: RSIO Loc
alloc' = do
    m <- get
    if M.null m then return 0
    else let (i, w) = M.findMax m in return (i + 1)

newtype MyException = MyException String
instance Exception MyException
instance Show (MyException s) where
    show (MyException s) = s

execStmt :: Stmt -> IO ()
execStmt s =
    (print =<< execStateT (runReaderT (interpret s) M.empty) M.empty)
    `catch` (\e -> putStrLn $ "Earthquake: " ++ show (e::MyException))

-- data Value = Int | Bool |
runProgram :: Program -> IO ()
runProgram
main = print $ evalState (runReaderT (eval testE) M.empty) M.empty

eval :: Expr -> VarType
eval _ = Int
