module Exception where

import qualified Control.Exception (Exception, throw)

newtype RuntimeException = RuntimeException String
instance Control.Exception.Exception RuntimeException
instance Show RuntimeException where
    show (RuntimeException s) = s

throw :: String -> a
throw msg = Control.Exception.throw (RuntimeException msg)
