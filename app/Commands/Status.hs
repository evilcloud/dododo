module Commands.Status
  ( changeStatus,
  )
where

import qualified Filter
import Task (Task (..), formatTask)
import qualified TasksIO
import qualified TimeMachine

-- Function to change the status of a task
changeStatus :: String -> String -> IO ()
changeStatus taskId newStatus = do
  tasks <- TasksIO.getAllTasksFromCurrent
  let taskMaybe = Filter.findByTaskId tasks taskId
  case taskMaybe of
    Just task -> do
      let updatedTask = task {status = newStatus}
      duration <- TimeMachine.casualDuration (creationTimestamp task)
      let updatedTaskWithDuration = updatedTask {statusDuration = duration}
      TasksIO.updateTaskInCurrent updatedTaskWithDuration
      putStrLn $ "Status of task " ++ taskId ++ " changed to " ++ newStatus
      putStrLn $ "Updated Task:"
      putStrLn $ (formatTask updatedTaskWithDuration)
    Nothing -> putStrLn $ "No task with " ++ taskId ++ " found"
