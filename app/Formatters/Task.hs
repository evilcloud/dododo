module Format.Task (formatTask) where

import qualified Config.Config as Config
import Task.Task (Task (..))

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
