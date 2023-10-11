module Commands.Reset (resetConfig) where

import Config.IO as CIO

resetConfig :: IO ()
resetConfig = do
  putStrLn "config.ini is reset to default"
  CIO.writeDefaultConfig