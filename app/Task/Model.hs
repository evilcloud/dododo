{-# LANGUAGE DuplicateRecordFields #-}

module Task.Model where

import Data.Time.Clock (NominalDiffTime, UTCTime, getCurrentTime)

-- Current time as UTCTime
currentTime :: IO UTCTime
currentTime = getCurrentTime

data Task = MicroTask Micro | TomorrowTask Tomorrow deriving (Show)

data Micro = Micro
  { creation :: UTCTime,
    taskId :: String,
    message :: String,
    status :: String,
    duration :: NominalDiffTime
  }
  deriving (Show)

data Tomorrow = Tomorrow
  { isDone :: Bool,
    taskId :: String,
    creation :: UTCTime,
    message :: String
  }
  deriving (Show)
