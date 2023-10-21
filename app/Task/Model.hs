{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE RecordWildCards #-}

module Task.Model where

import Data.Time.Clock (UTCTime, getCurrentTime)

-- Current time as UTCTime
currentTime :: IO UTCTime
currentTime = getCurrentTime

data Task = MicroTask Micro | TomorrowTask Tomorrow deriving (Show)

data Status = Done | Undone deriving (Show, Eq)

data Micro = Micro
  { creation :: UTCTime,
    taskId :: String,
    message :: String,
    status :: String,
    duration :: String
  }
  deriving (Show)

data Tomorrow = Tomorrow
  { isDone :: Status,
    taskId :: String,
    creation :: UTCTime,
    message :: String
  }
  deriving (Show)

getMicroCreationTime :: Micro -> UTCTime
getMicroCreationTime Micro {..} = creation

getTomorrowCreationTime :: Tomorrow -> UTCTime
getTomorrowCreationTime Tomorrow {..} = creation

getCreationTime :: Task -> UTCTime
getCreationTime (MicroTask micro) = getMicroCreationTime micro
getCreationTime (TomorrowTask tomorrow) = getTomorrowCreationTime tomorrow
