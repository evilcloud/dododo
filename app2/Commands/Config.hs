module Commands.Config (configCommand) where

import qualified Config.Config as Config

configCommand :: [String] -> IO ()
configCommand [] = do
  config <- Config.getConfig
  putStrLn "Showing config here"
configCommand ["reset"] = do
  putStrLn "Reset config to default"
  Config.resetToDefault
configCommand _ = putStrLn "Invalid config command"
