module Commands.Lifetime (lifetime) where

import qualified Config.Lifetime as Lifetime

lifetime :: [String] -> IO ()
lifetime [] = Lifetime.printLifetime
lifetime (arg : _) = Lifetime.setLifetime arg
