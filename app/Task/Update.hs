module Task.Update
  ( updateMicroTask
  , updateTomorrowTask
  ) where

import Data.Time
import Task.Model

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
