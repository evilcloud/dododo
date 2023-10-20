-- module Collection.IO where

-- import qualified Config.Config as Config
-- import qualified Task.Parser as Parser
-- import qualified Utils.FileManager as FileManager

-- loadTasks :: IO [String]
-- loadTasks = do
--   let taskPath = Config.current
--   content <- FileManager.readFromFile taskPath
--   return $ lines content

-- module Collection.IO where

-- import qualified Config.Config as Config
-- import Task.Model (Task)
-- import Task.Parser (parseTask)
-- import qualified Task.String as String
-- import qualified Utils.FileManager as FileManager

-- loadTasks :: IO ()
-- loadTasks = do
--   let taskPath = Config.current
--   content <- FileManager.readFromFile taskPath
--   let tasks = map parseTask $ lines content
--   mapM_ (maybe (putStrLn "Failed to parse task") printTask) tasks
--   where
--     printTask :: Task -> IO ()
--     printTask task = do
--       taskStr <- String.toDisplayString task
--       putStrLn taskStr

module Collection.IO where

import qualified Config.Config as Config
import Control.Monad (forM_)
import Data.Maybe (fromJust, isJust)
import Task.Model (Micro, Task (..), Tomorrow)
import Task.Parser (parseTask)
import Task.String (Stringify, toDisplayString)
import qualified Utils.FileManager as FileManager

loadTasks :: IO ([Micro], [Tomorrow])
loadTasks = do
  let taskPath = Config.current
  content <- FileManager.readFromFile taskPath
  let tasks = map parseTask $ lines content
  let validTasks = filter isJust tasks
  let microTasks = [micro | MicroTask micro <- map fromJust validTasks]
  let tomorrowTasks = [tomorrow | TomorrowTask tomorrow <- map fromJust validTasks]
  printTasks "Micro Tasks:" microTasks
  printTasks "Tomorrow Tasks:" tomorrowTasks
  return (microTasks, tomorrowTasks)

printTasks :: (Stringify a) => String -> [a] -> IO ()
printTasks taskType tasks = do
  putStrLn taskType
  forM_ tasks $ \task -> do
    taskStr <- toDisplayString task
    putStrLn taskStr
