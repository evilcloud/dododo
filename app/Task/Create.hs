module Task.Create
  ( createMicroTask
  , createTomorrowTask
  ) where

import Data.Time
import Task.Model
import Task.TaskId as TaskId

createMicroTask :: String -> IO Task
createMicroTask msg = do
  now <- getZonedTime
  id <- TaskId.generateId
  let localTime = zonedTimeToLocalTime now
  return $ MicroTask localTime id msg Nothing Nothing

createTomorrowTask :: String -> IO Task
createTomorrowTask msg = do
  id <- TaskId.generateId
  return $ TomorrowTask False id msg
