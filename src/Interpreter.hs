{-# LANGUAGE ScopedTypeVariables #-}

module Main (main) where

import qualified Data.Map as M
import qualified Control.Monad
import Control.Exception (Handler(..), catch, catches)
import Control.Monad.State (execStateT)
import System.Environment (getArgs)
import System.IO (hPutStrLn, stderr)

import LexSimplego
import ParSimplego
import AbsSimplego
import Interpret
import Exception
import ErrM
import TypeCheck
import Common

main :: IO ()
main = do
    args <- getArgs
    case args of
        [] -> getContents >>= run
        [filename] -> readFile filename >>= run

run :: String -> IO ()
run sourceCode =
    let ts = myLexer sourceCode in case pProgram ts of
        Bad s -> printError "Parsing exception" s
        Ok tree -> runProgram tree

runProgram :: Program LineCol -> IO ()
runProgram p =
    Control.Monad.void (execStateT (typeCheckProgram p) M.empty >>
        execStateT (execProgram p) (M.empty, M.empty))
    `catches` [Handler (\ (e :: RuntimeException) -> printError "Runtime exception" (show e)),
               Handler (\ (e :: TypeException) -> printError "Type exception" (show e))]

printError :: String -> String -> IO ()
printError source msg = hPutStrLn stderr (source ++ ": " ++ msg)
