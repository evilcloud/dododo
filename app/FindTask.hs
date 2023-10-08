module FindTask
  ( findAndPrintTaskById,
    findByTaskId,
  )
where

import qualified Filter
import qualified Task.Task as Task (Task (..), formatTask, taskId)
import qualified TasksArray.TasksIO as TasksIO

-- Function to find a task by its taskId
findByTaskId :: String -> IO (Maybe Task.Task)
findByTaskId searchId = do
  tasks <- TasksIO.getAllTasksFromCurrent
  return $ Filter.findByTaskId tasks searchId

-- Function to find a task by its taskId and print it
findAndPrintTaskById :: String -> IO ()
findAndPrintTaskById taskId = do
  taskMaybe <- findByTaskId taskId
  case taskMaybe of
    Just task -> putStrLn $ Task.formatTask task
    Nothing -> putStrLn $ "No task with " ++ taskId ++ " found"
