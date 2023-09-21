module TasksIO
  ( addTaskToCurrent,
    getAllTasksFromCurrent,
    findTaskById,
    updateTaskInCurrent,
    deleteTaskInCurrent,
  )
where

import qualified Config
import Data.List (find, sortOn)
import Data.Maybe (mapMaybe)
import qualified FileManager
import qualified Task
import qualified TaskParser

-- Function to add a task to the current file
addTaskToCurrent :: Task.Task -> IO ()
addTaskToCurrent task = do
  let formattedTask = Task.formatTask task
  FileManager.appendToFile Config.current formattedTask

-- Function to get all tasks from the current file
getAllTasksFromCurrent :: IO [Task.Task]
getAllTasksFromCurrent = do
  content <- FileManager.readFromFile Config.current
  let contentLines = lines content
  let maybeTasks = map TaskParser.parseTask contentLines
  return $ mapMaybe id maybeTasks

-- Function to update a task in the current file
updateTaskInCurrent :: Task.Task -> IO ()
updateTaskInCurrent updatedTask = do
  tasks <- getAllTasksFromCurrent
  let updatedTasks = map (\task -> if Task.taskId task == Task.taskId updatedTask then updatedTask else task) tasks
  let sortedTasks = sortOn Task.creationTimestamp updatedTasks
  let formattedTasks = map Task.formatTask sortedTasks
  let content = unlines formattedTasks
  FileManager.updateFile Config.current content

deleteTaskInCurrent :: String -> IO ()
deleteTaskInCurrent taskIdToDelete = do
  tasks <- getAllTasksFromCurrent
  let updatedTasks = filter (\task -> Task.taskId task /= taskIdToDelete) tasks
  let sortedTasks = sortOn Task.creationTimestamp updatedTasks
  let formattedTasks = map Task.formatTask sortedTasks
  let content = unlines formattedTasks
  FileManager.updateFile Config.current content

-- Function to find a task by ID
findTaskById :: String -> [Task.Task] -> Maybe Task.Task
findTaskById id = find ((== id) . Task.taskId)
