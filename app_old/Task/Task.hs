module Task.Task
  ( Task (..),
    updateTask,
    formatTask,
  )
where

import qualified Config
import Timestamp (createTimestamp, timeDiffCasual)

data Task = Task
  { taskId :: String,
    taskMessage :: String,
    creationTimestamp :: String,
    status :: String,
    statusDuration :: String
  }
  deriving (Show, Eq, Ord)

-- Function to update a task's status
updateTask :: Task -> String -> IO Task
updateTask task newStatus = do
  timestamp <- Timestamp.createTimestamp
  let duration = Timestamp.timeDiffCasual (creationTimestamp task) timestamp
  return task {status = newStatus, statusDuration = duration}

-- Constants for the format
separator, prefix :: String
separator = Config.taskInternalSeparator
prefix = " "

-- Function to format a task
formatTask :: Task -> String
formatTask task =
  prefix
    ++ creationTimestamp task
    ++ separator
    ++ taskId task
    ++ separator
    ++ taskMessage task
    ++ ( if status task /= "open"
           then separator ++ status task ++ " " ++ statusDuration task
           else ""
       )
