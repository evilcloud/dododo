module Commands.New
  ( new,
  )
where

import qualified Generator
import qualified Task.Task as Task
import qualified TasksIO
import Timestamp (createTimestamp)

-- Function to create a new task
createTask :: String -> IO Task.Task
createTask message = do
  taskId <- Generator.taskID
  timestamp <- Timestamp.createTimestamp
  return
    Task.Task
      { Task.taskId = taskId,
        Task.taskMessage = message,
        Task.creationTimestamp = timestamp,
        Task.status = "open",
        Task.statusDuration = "none"
      }

-- Function for the 'new' command
new :: String -> IO ()
new message = do
  task <- createTask message
  TasksIO.addTaskToCurrent task
  putStrLn $ Task.formatTask task ++ "\n"
