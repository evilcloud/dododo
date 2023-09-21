module FindTask
  ( findAndPrintTaskById,
    findByTaskId,
  )
where

import qualified Filter
import Task (Task (..), formatTask, taskId)
import qualified TasksIO

-- Function to find a task by its taskId
findByTaskId :: String -> IO (Maybe Task)
findByTaskId searchId = do
  tasks <- TasksIO.getAllTasksFromCurrent
  return $ Filter.findByTaskId tasks searchId

-- Function to find a task by its taskId and print it
findAndPrintTaskById :: String -> IO ()
findAndPrintTaskById taskId = do
  taskMaybe <- findByTaskId taskId
  case taskMaybe of
    Just task -> putStrLn $ formatTask task
    Nothing -> putStrLn $ "No task with " ++ taskId ++ " found"
