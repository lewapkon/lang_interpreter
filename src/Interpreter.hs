module Main (main) where

import qualified Data.Map as M
import Control.Exception (Exception, catch, throw)
import Control.Monad.State (execStateT)

import System.Environment (getArgs)

import LexSimplego
import ParSimplego
import AbsSimplego
import Interpret
import Exception
import ErrM

main :: IO ()
main = do
    args <- getArgs
    case args of
        [filename] -> do
            sourceCode <- readFile filename
            let ts = myLexer sourceCode in case pProgram ts of
                Bad s -> error s
                Ok tree -> runProgram tree

runProgram :: Program -> IO ()
runProgram p =
    (print =<< execStateT (execProgram p) (M.empty, M.empty))
    `catch` (\e -> putStrLn $ "Runtime exception: " ++ show (e::RuntimeException))
