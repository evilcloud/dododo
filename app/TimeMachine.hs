module TimeMachine
  ( casualDuration,
  )
where

import Data.Time.Clock
import Data.Time.Format
import Data.Time.Format (defaultTimeLocale)
import Data.Time.LocalTime (ZonedTime, getZonedTime, utc, utcToLocalTime, zonedTimeToUTC)

-- Function to sanitize and parse a timestamp
parseTimestamp :: String -> ZonedTime
parseTimestamp timestamp =
  parseTimeOrError True defaultTimeLocale "%Y-%m-%d %H:%M" timestamp :: ZonedTime

-- Function to calculate the casual duration
casualDuration :: String -> IO String
casualDuration timestampStr = do
  let timestamp = parseTimestamp timestampStr
  rawCurrentTime <- getZonedTime
  let currentTimeStr = formatTime defaultTimeLocale "%Y-%m-%d %H:%M" rawCurrentTime
  let sanitizedCurrentTime = parseTimestamp currentTimeStr
  let diff = abs $ diffUTCTime (zonedTimeToUTC sanitizedCurrentTime) (zonedTimeToUTC timestamp)
  return $ "@" ++ formatDuration diff

-- Function to format a duration
formatDuration :: NominalDiffTime -> String
formatDuration diff
  | diff < 0 = "in the future"
  | diff < 60 = "< 1 min"
  | diff < 3600 = show (floor diff `div` 60) ++ " min"
  | diff < 14400 = show (floor diff `div` 3600) ++ " hours " ++ show ((floor diff `mod` 3600) `div` 60) ++ " min"
  | diff < 86400 = show (floor diff `div` 3600) ++ " hours"
  | otherwise = show (floor diff `div` 86400) ++ " days"
