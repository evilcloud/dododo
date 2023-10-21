{-# LANGUAGE RecordWildCards #-}

module Task.Constructor where

import Data.Time.Clock
import Task.Model
import qualified Task.TaskId as TaskId

newMicro :: String -> IO Micro
newMicro msg = do
  currentUTCTime <- currentTime
  id <- TaskId.generateId
  return Micro {status = "", creation = currentUTCTime, taskId = id, message = msg, duration = ""}

newTomorrow :: String -> IO Tomorrow
newTomorrow msg = do
  currentUTCTime <- currentTime
  id <- TaskId.generateId
  return Tomorrow {isDone = Undone, taskId = id, creation = currentUTCTime, message = msg}
