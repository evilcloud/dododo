module Task.Task
  ( Task(..)
  , createMicroTask
  , createTomorrowTask
  , updateMicroTask
  , updateTomorrowTask
  )
where

import Data.Time
import Data.Time.Format (formatTime, defaultTimeLocale)
import Task.TaskId as TaskId

data Task = MicroTask
  { creation :: LocalTime
  , taskId :: String
  , message :: String
  , status :: Maybe String
  , duration :: Maybe NominalDiffTime
  } 
  | TomorrowTask
  { todoChecked :: Bool
  , taskId :: String
  , message :: String
  } deriving (Show, Eq)
  
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


updateMicroTask :: Task -> String -> IO Task
updateMicroTask task status = do
  now <- getCurrentTime
  let nowLocal = utcToLocalTime utc now
  case task of
    MicroTask {creation = creation, taskId = taskId, message = message, status = _, duration = duration} -> 
      let newDuration = diffLocalTime nowLocal creation
      in return $ task {status = Just status, duration = Just newDuration}
    _ -> return task



updateTomorrowTask :: Task -> IO Task
updateTomorrowTask task = 
  case task of
    TomorrowTask {todoChecked = todoChecked, taskId = taskId, message = message} ->
      return $ task {todoChecked = not todoChecked}
    _ -> return task



failedSubmission :: Task -> IO Task
failedSubmission task = do
  putStrLn "Failed to update the task"
  return task
