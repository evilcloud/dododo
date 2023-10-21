{-# LANGUAGE RecordWildCards #-}

module Task.Status where

import Control.Monad (when)
import Task.Model (Micro (..), Status (..), Task (..), Tomorrow (..))
import Task.String (toSimpleString)

-- Function to change the status of a Micro task
changeMicroStatus :: String -> Maybe String -> Micro -> IO Micro
changeMicroStatus taskIdParam maybeNewStatus micro@Micro {..}
  | taskIdParam == taskId = do
      let newStatus = case maybeNewStatus of
            Just status -> status
            Nothing -> if status == "incomplete" then "done" else ""
      simpleString <- toSimpleString $ micro {status = newStatus}
      putStrLn $ "Task has been updated to: \n" ++ simpleString
      return micro {status = newStatus}
  | otherwise = return micro

-- Function to toggle the status of a Tomorrow task
toggleTomorrowStatus :: String -> Tomorrow -> IO Tomorrow
toggleTomorrowStatus taskIdParam tomorrow@Tomorrow {..}
  | taskIdParam == taskId = do
      let newStatus = toggleStatus isDone
      simpleString <- toSimpleString $ tomorrow {isDone = newStatus}
      putStrLn $ "Task has been updated to: \n" ++ simpleString
      return tomorrow {isDone = newStatus}
  | otherwise = return tomorrow

toggleStatus :: Status -> Status
toggleStatus Done = Undone
toggleStatus Undone = Done

-- Function to change the status of a task
changeTaskStatus :: String -> Maybe String -> Task -> IO Task
changeTaskStatus taskIdParam maybeNewStatus (MicroTask micro) = do
  updatedMicro <- changeMicroStatus taskIdParam maybeNewStatus micro
  return $ MicroTask updatedMicro
changeTaskStatus taskIdParam _ (TomorrowTask tomorrow) = do
  updatedTomorrow <- toggleTomorrowStatus taskIdParam tomorrow
  return $ TomorrowTask updatedTomorrow
