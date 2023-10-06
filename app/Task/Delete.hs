-- Task/Delete.hs
module Task.Delete (deleteTasks) where

import Data.List (elem)
import Filter (findByTaskId)
import qualified Task.Task as Task (Task (..), formatTask)
import TasksIO (deleteTaskInCurrent, findTaskById, getAllTasksFromCurrent)

deleteTasks :: [String] -> IO ()
deleteTasks taskIds = do
  tasks <- getAllTasksFromCurrent
  mapM_
    ( \taskId ->
        case findTaskById taskId tasks of
          Nothing -> putStrLn $ "Task ID " ++ taskId ++ " is not found\nNothing deleted"
          Just task -> do
            deleteTaskInCurrent taskId
            putStrLn $ "Deleted:\n" ++ Task.formatTask task
    )
    taskIds
