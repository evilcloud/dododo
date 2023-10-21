module Collection.IO
  ( appendMicro,
    loadTasks,
    saveTasks,
  )
where

import qualified Collection.Filter as Filter
import qualified Config.Config as Config
import Data.Maybe (fromJust, isJust)
import Task.Model (Task (..))
import Task.Parser as Parser
import qualified Utils.FileManager as FileManager

loadTasks :: IO [Task]
loadTasks = do
  let taskPath = Config.current
  content <- FileManager.readFromFile taskPath
  let tasks = map Parser.parseTask $ lines content
  let validTasks = filter isJust tasks
  let allTasks = map fromJust validTasks
  sortedTasks <- return $ Filter.sortTasks allTasks

  return allTasks

saveTasks :: [String] -> IO ()
saveTasks taskStrings = do
  let content = unlines taskStrings
  FileManager.writeToFile Config.current content

appendMicro :: String -> IO ()
appendMicro = FileManager.appendToFile Config.current
