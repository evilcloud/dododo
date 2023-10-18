module Collection.IO where

import qualified Config.Config as Config
import qualified Utils.FileManager as FileManager

loadTasks :: IO [String]
loadTasks = do
  let taskPath = Config.current
  content <- FileManager.readFromFile taskPath
  return $ lines content
