module Task.New (new) where

import qualified Task.Generator as Generator
import qualified Task.Task as Task
import qualified TasksArray.TasksIO as TasksIO
import Timestamp (createTimestamp)

new :: String -> IO ()
new message = do
  task <- createTask message
  TasksIO.addTaskToCurrent task
  putStrLn $ Task.formatTask task ++ "\n"

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
