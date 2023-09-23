module Commands.Delete
  ( deleteTasks,
  )
where

import Data.List (elem)
import Filter (findByTaskId)
import Task (Task (..), formatTask) -- Updated import
import TasksIO (deleteTaskInCurrent, findTaskById, getAllTasksFromCurrent) -- Updated import

deleteTasks :: [String] -> IO ()
deleteTasks taskIds = do
  tasks <- getAllTasksFromCurrent
  mapM_
    ( \taskId ->
        case findTaskById taskId tasks of
          Nothing -> putStrLn $ "Task ID " ++ taskId ++ " is not found\nNothing deleted"
          Just task -> do
            deleteTaskInCurrent taskId
            putStrLn $ "Deleted:\n" ++ (formatTask task)
    )
    taskIds
