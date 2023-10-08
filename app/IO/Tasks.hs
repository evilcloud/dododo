module IO.Tasks
  ( addTaskToCurrent,
    getAllTasksFromCurrent,
    findTaskById,
    updateTaskInCurrent,
    deleteTaskInCurrent,
    addTaskToPast,
    getAllTaskIds,
  )
where

import qualified Config.Config as Config
import Data.List (find, sortOn)
import Data.Maybe (mapMaybe)
import qualified FileManager.FileManager as FileManager
import qualified Format.Parse as Parse
import qualified Task.Task as Task

-- Function to get all tasks from the current file
getAllTasksFromCurrent :: IO [Task.Task]
getAllTasksFromCurrent = do
  config <- Config.getConfig
  let currentPath = Config.get config "PATHS" "current"
  content <- FileManager.readFromFile (either (const "") id currentPath)
  let contentLines = lines content
  let maybeTasks = map Parse.parseTask contentLines
  return $ mapMaybe id maybeTasks

-- Function to add a task to the current file
addTaskToCurrent :: Task.Task -> IO ()
addTaskToCurrent task = do
  config <- Config.getConfig
  let currentPath = Config.get config "PATHS" "current"
  let formattedTask = Task.formatTask task ++ "\n"
  FileManager.appendToFile (either (const "") id currentPath) formattedTask

-- Function to update a task in the current file
updateTaskInCurrent :: Task.Task -> IO ()
updateTaskInCurrent updatedTask = do
  config <- Config.getConfig
  let currentPath = Config.get config "PATHS" "current"
  tasks <- getAllTasksFromCurrent
  let updatedTasks = map (\task -> if Task.taskId task == Task.taskId updatedTask then updatedTask else task) tasks
  FileManager.writeTasksToFile (either (const "") id currentPath) updatedTasks

deleteTaskInCurrent :: String -> IO ()
deleteTaskInCurrent taskIdToDelete = do
  config <- Config.getConfig
  let currentPath = Config.get config "PATHS" "current"
  tasks <- getAllTasksFromCurrent
  let updatedTasks = filter (\task -> Task.taskId task /= taskIdToDelete) tasks
  FileManager.writeTasksToFile (either (const "") id currentPath) updatedTasks

-- Function to add a task to the past file
addTaskToPast :: Task.Task -> IO ()
addTaskToPast task = do
  config <- Config.getConfig
  let pastPath = Config.get config "PATHS" "past"
  let formattedTask = Task.formatTask task ++ "\n"
  FileManager.appendToFile (either (const "") id pastPath) formattedTask

-- Function to find a task by ID
findTaskById :: String -> [Task.Task] -> Maybe Task.Task
findTaskById id = find ((== id) . Task.taskId)

-- Function to write tasks to a file
writeTasksToFile :: String -> [Task.Task] -> IO ()
writeTasksToFile filename tasks = do
  let sortedTasks = map Task.formatTask $ sortTasks tasks
  let content = unlines sortedTasks
  FileManager.updateFile filename content

-- Function to sort tasks by creation timestamp
sortTasks :: [Task.Task] -> [Task.Task]
sortTasks = sortOn Task.creationTimestamp

getAllTaskIds :: IO [String]
getAllTaskIds = map Task.taskId <$> getAllTasksFromCurrent
