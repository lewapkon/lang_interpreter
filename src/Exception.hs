module Exception where

import qualified Control.Exception (Exception, throw)

newtype RuntimeException = RuntimeException String
instance Control.Exception.Exception RuntimeException
instance Show RuntimeException where
    show (RuntimeException s) = s

newtype TypeException = TypeException String
instance Control.Exception.Exception TypeException
instance Show TypeException where
    show (TypeException s) = s

throwRuntime :: String -> a
throwRuntime msg = Control.Exception.throw (RuntimeException msg)

throwType :: String -> a
throwType msg = Control.Exception.throw (TypeException msg)
