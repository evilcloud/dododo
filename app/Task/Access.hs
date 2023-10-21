{-# LANGUAGE RecordWildCards #-}

module Task.Access (getCreationTime) where

import Data.Time.Clock (UTCTime)
import Task.Model (Micro (..), Task (..), Tomorrow (..))

getMicroCreationTime :: Micro -> UTCTime
getMicroCreationTime Micro {..} = creation

getTomorrowCreationTime :: Tomorrow -> UTCTime
getTomorrowCreationTime Tomorrow {..} = creation

getCreationTime :: Task -> UTCTime
getCreationTime (MicroTask micro) = getMicroCreationTime micro
getCreationTime (TomorrowTask tomorrow) = getTomorrowCreationTime tomorrow
