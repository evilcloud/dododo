module Task.IO where

import qualified Collection.Stdout as Stdout
import qualified Config.Config as Config
import qualified Utils.FileManager as FileManager

addMicroToFile :: String -> IO ()
addMicroToFile microString = do
  -- let taskPath = Config.current
  -- FileManager.appendToFile taskPath microString
  Stdout.appendMicro microString