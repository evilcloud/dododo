module TaskParser
  ( parseTasks,
    parseTask,
  )
where

import Data.List.Split (splitOn)
import qualified Data.Text as T
import qualified Task

sanitize :: String -> String
sanitize = T.unpack . T.strip . T.pack

parseTask :: String -> Maybe Task.Task
parseTask line =
  let parts = map sanitize $ splitOn "|" line
   in if length parts >= 3
        then
          let (status, duration) = if length parts > 3 then parseStatusAndDuration (parts !! 3) else ("open", "none")
           in Just
                Task.Task
                  { Task.taskId = parts !! 1,
                    Task.taskMessage = parts !! 2,
                    Task.creationTimestamp = parts !! 0,
                    Task.status = status,
                    Task.statusDuration = duration
                  }
        else Nothing

parseTasks :: [String] -> [Maybe Task.Task]
parseTasks = map parseTask

parseStatusAndDuration :: String -> (String, String)
parseStatusAndDuration taskDescription =
  let parts = words taskDescription
   in if not (null parts)
        then (head parts, unwords (tail parts))
        else ("open", "none")
