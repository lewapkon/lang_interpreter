module Exception where

import qualified Control.Exception (Exception, throw)
import Common

newtype RuntimeException = RuntimeException (String, LineCol)
instance Control.Exception.Exception RuntimeException
instance Show RuntimeException where
    show (RuntimeException (s, Just (line, _))) = s ++ " at line " ++ show line

newtype TypeException = TypeException (String, LineCol)
instance Control.Exception.Exception TypeException
instance Show TypeException where
    show (TypeException (s, Just (line, _))) = s ++ " at line " ++ show line

throwRuntime :: String -> LineCol -> a
throwRuntime msg loc = Control.Exception.throw (RuntimeException (msg, loc))

throwType :: String -> LineCol -> a
throwType msg loc = Control.Exception.throw (TypeException (msg, loc))
