{-# LANGUAGE OverloadedStrings #-}

module Utils.TimeMachine
  ( utcToLocal,
    localToUTCTime,
    timeDifference,
  )
where

import Data.Time
import Data.Time.LocalTime (getCurrentTimeZone, localTimeToUTC, utcToLocalTime)

utcToLocal :: UTCTime -> IO LocalTime
utcToLocal utctime = do
  tz <- getCurrentTimeZone
  return $ utcToLocalTime tz utctime

localToUTCTime :: LocalTime -> IO UTCTime
localToUTCTime localtime = do
  tz <- getCurrentTimeZone
  return $ localTimeToUTC tz localtime

timeDifference :: UTCTime -> UTCTime -> NominalDiffTime
timeDifference time1 time2 = diffUTCTime time1 time2
