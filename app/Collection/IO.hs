-- module Collection.IO where

-- import qualified Config.Config as Config
-- import qualified Task.Parser as Parser
-- import qualified Utils.FileManager as FileManager

-- loadTasks :: IO [String]
-- loadTasks = do
--   let taskPath = Config.current
--   content <- FileManager.readFromFile taskPath
--   return $ lines content

module Collection.IO where

import qualified Config.Config as Config
import Task.Model (Task)
import Task.Parser (parseTask)
import qualified Task.String as String
import qualified Utils.FileManager as FileManager

loadTasks :: IO ()
loadTasks = do
  let taskPath = Config.current
  content <- FileManager.readFromFile taskPath
  let tasks = map parseTask $ lines content
  mapM_ (maybe (putStrLn "Failed to parse task") printTask) tasks
  where
    printTask :: Task -> IO ()
    printTask task = do
      taskStr <- String.toDisplayString task
      putStrLn taskStr
