module Commands.Lifetime where

import qualified Config.Lifetime as Lifetime
import Data.Maybe (isJust) -- Add this line
import qualified Help.Commands as Help
import Text.Read (readMaybe)

lifetime :: [String] -> IO ()
lifetime [] = Lifetime.printLifetime
lifetime (arg : _)
  | isJust (readMaybe arg :: Maybe Int) = Lifetime.setLifetime arg
  | otherwise = Help.getHelp "lifetime"
