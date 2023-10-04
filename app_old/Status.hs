module Status
  ( changeStatus,
  )
where

import qualified Filter
import qualified Task.Task as Task (Task (..), formatTask)
import qualified TasksIO
import qualified TimeMachine

-- Function to change the status of a task
changeStatus :: String -> String -> IO ()
changeStatus taskId newStatus = do
  taskIds <- TasksIO.getAllTaskIds
  if taskId `elem` taskIds
    then do
      tasks <- TasksIO.getAllTasksFromCurrent
      let taskMaybe = Filter.findByTaskId tasks taskId
      case taskMaybe of
        Just task -> do
          let updatedTask = task {Task.status = newStatus}
          duration <- TimeMachine.casualDuration (Task.creationTimestamp task)
          let updatedTaskWithDuration = updatedTask {Task.statusDuration = duration}
          TasksIO.updateTaskInCurrent updatedTaskWithDuration
          putStrLn $ "Status of task " ++ taskId ++ " changed to " ++ newStatus
          putStrLn $ "Updated Task:"
          putStrLn $ (Task.formatTask updatedTaskWithDuration)
        Nothing -> putStrLn $ "No task with " ++ taskId ++ " found"
    else putStrLn $ "TaskId " ++ taskId ++ " does not exist"
