module New.New where

import qualified Config.Config as Config
import Data.ConfigFile (get)
import qualified FileManager.FileManager as FM
import qualified Task.Format as Format
import qualified Task.Task as Task

createNewTask :: [String] -> IO ()
createNewTask words = do
  let message = unwords words
  task <- Task.createMicroTask message
  taskStr <- Format.taskForFile task
  config <- Config.getConfig
  let taskFilePath = get config "PATHS" "current"
  case taskFilePath of
    Left _ -> putStrLn "Error: Could not get task file path from configuration."
    Right path -> do
      FM.appendToFile path (taskStr ++ "\n")
      printTask task

printTask :: Task.Task -> IO ()
printTask task = do
  taskStr <- Format.taskForPrint task
  putStrLn taskStr
