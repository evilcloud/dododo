module Format.Parse (parseTask) where

import Data.List.Split (splitOn)
import Data.Maybe (listToMaybe)
import qualified Task.Task as Task

parseTask :: String -> Maybe Task.Task
parseTask line = do
  let parts = splitOn "  |  " line
  if length parts < 3
    then Nothing
    else do
      let timestamp = parts !! 0
      let taskId = parts !! 1
      let message = parts !! 2
      let statusDuration =
            if length parts > 3
              then Just (splitOn " @" (parts !! 3))
              else Nothing
      let status = fmap head statusDuration
      let duration = fmap last statusDuration >>= listToMaybe
      return Task.MicroTask {Task.taskId = taskId, Task.message = message, Task.status = status, Task.duration = duration}
