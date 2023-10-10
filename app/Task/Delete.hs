-- Task/Delete.hs
module Task.Delete (deleteTasks) where

import Data.List (elem)
import Handlers.Filter as Filter (findByTaskId)
import qualified Task.Task as Task (Task (..), formatTask)
import qualified TasksArray.TasksIO as TasksIO

-- import qualified TasksIO as TIO

deleteTasks :: [String] -> IO ()
deleteTasks taskIds = do
  tasks <- TasksIO.getAllTasksFromCurrent
  mapM_
    ( \taskId ->
        case TasksIO.findTaskById taskId tasks of
          Nothing -> putStrLn $ "Task ID " ++ taskId ++ " is not found\nNothing deleted"
          Just task -> do
            TasksIO.deleteTaskInCurrent taskId
            putStrLn $ "Deleted:\n" ++ Task.formatTask task
    )
    taskIds
