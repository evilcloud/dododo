module Format.Parse (parseMicro) where

import Data.List.Split (splitOn)
import Data.Maybe (listToMaybe)
import qualified Task.Task as Task

parseMicro :: String -> Maybe Task.Task
parseMicro line = do
  let parts = splitOn "  |  " line
  if length parts < 3
    then Nothing
    else do
      let creation = parts !! 0
      let taskId = parts !! 1
      let message = parts !! 2
      let statusDuration =
            if length parts > 3
              then Just (splitOn " @" (parts !! 3))
              else Nothing
      let status = fmap head statusDuration
      let duration = fmap last statusDuration >>= listToMaybe
      return Task.MicroTask {Task.taskId = taskId, Task.message = message, Task.status = status, Task.duration = duration}

parseTomorrow :: String -> Task.Tomorrow
parseTomorrow line = do
  let parts = splitOn "  |  " line
  if length parts < 3
    then Nothing
    else do
      let timestamp = parts !! 0
      let complete = part !! 1
      let taskId = parts !! 2
      let message = part !! 3
