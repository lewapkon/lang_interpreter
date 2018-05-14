{-# LANGUAGE ScopedTypeVariables #-}

module Main (main) where

import qualified Data.Map as M
import qualified Control.Monad
import Control.Exception (Handler(..), catch, catches)
import Control.Monad.State (execStateT)

import System.Environment (getArgs)

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
        [filename] -> do
            sourceCode <- readFile filename
            let ts = myLexer sourceCode in case pProgram ts of
                Bad s -> error s
                Ok tree -> runProgram tree

runProgram :: Program LineCol -> IO ()
runProgram p =
    Control.Monad.void (execStateT (typeCheckProgram p) M.empty >>
        execStateT (execProgram p) (M.empty, M.empty))
    `catches` [Handler (\ (e :: RuntimeException) -> putStrLn ("Runtime exception: " ++ show e)),
               Handler (\ (e :: TypeException) -> putStrLn ("Type exception: " ++ show e))]
