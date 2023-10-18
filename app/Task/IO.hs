module Task.IO where

import qualified Config.Config as Config
import qualified Task.Model as TM
import qualified Utils.FileManager as FileManager

addMicroToFile :: String -> IO ()
addMicroToFile microString = do
  let taskPath = Config.current
  FileManager.appendToFile taskPath microString