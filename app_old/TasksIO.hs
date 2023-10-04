module TasksIO
  ( addTaskToCurrent,
    getAllTasksFromCurrent,
    findTaskById,
    updateTaskInCurrent,
    deleteTaskInCurrent,
    addTaskToPast,
    getAllTaskIds,
  )
where

import qualified Config
import Data.List (find, sortOn)
import Data.Maybe (mapMaybe)
import qualified FileManager
import qualified Task.Task as Task
import qualified TaskParser

-- Function to get all tasks from the current file
getAllTasksFromCurrent :: IO [Task.Task]
getAllTasksFromCurrent = do
  content <- FileManager.readFromFile Config.current
  let contentLines = lines content
  let maybeTasks = map TaskParser.parseTask contentLines
  return $ mapMaybe id maybeTasks

-- Function to add a task to the current file
addTaskToCurrent :: Task.Task -> IO ()
addTaskToCurrent task = do
  tasks <- getAllTasksFromCurrent
  let updatedTasks = task : tasks
  writeTasksToFile Config.current updatedTasks

-- Function to update a task in the current file
updateTaskInCurrent :: Task.Task -> IO ()
updateTaskInCurrent updatedTask = do
  tasks <- getAllTasksFromCurrent
  let updatedTasks = map (\task -> if Task.taskId task == Task.taskId updatedTask then updatedTask else task) tasks
  writeTasksToFile Config.current updatedTasks

deleteTaskInCurrent :: String -> IO ()
deleteTaskInCurrent taskIdToDelete = do
  tasks <- getAllTasksFromCurrent
  let updatedTasks = filter (\task -> Task.taskId task /= taskIdToDelete) tasks
  writeTasksToFile Config.current updatedTasks

-- Function to add a task to the past file
addTaskToPast :: Task.Task -> IO ()
addTaskToPast task =
  let formattedTask = Task.formatTask task ++ "\n"
   in FileManager.appendToFile Config.past formattedTask

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
