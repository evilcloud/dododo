module TimeMachine
  ( casualDuration,
    casualTime,
    parseTimestamp,
  )
where

import Data.Time.Calendar (diffDays, toGregorian)
import Data.Time.Clock
import Data.Time.Format
import Data.Time.LocalTime (ZonedTime, getZonedTime, localDay, utc, utcToLocalTime, zonedTimeToLocalTime, zonedTimeToUTC)

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

-- Function to calculate the casual time
casualTime :: String -> IO String
casualTime timestampStr = do
  let timestamp = parseTimestamp timestampStr
  rawCurrentTime <- getZonedTime
  let currentTimeStr = formatTime defaultTimeLocale "%Y-%m-%d %H:%M" rawCurrentTime
  let sanitizedCurrentTime = parseTimestamp currentTimeStr
  let daysDiff = diffDays (localDay $ zonedTimeToLocalTime sanitizedCurrentTime) (localDay $ zonedTimeToLocalTime timestamp)
  let timeStr = formatTime defaultTimeLocale "%H:%M" timestamp
  return $ case daysDiff of
    0 -> "Today " ++ timeStr
    1 -> "Yesterday " ++ timeStr
    _ | daysDiff < 7 -> formatTime defaultTimeLocale "%A %H:%M" timestamp
    _ | sameMonth sanitizedCurrentTime timestamp -> formatTime defaultTimeLocale "%dth" timestamp
    _ -> formatTime defaultTimeLocale "%d %B" timestamp

-- Function to check if two timestamps are in the same month
sameMonth :: ZonedTime -> ZonedTime -> Bool
sameMonth t1 t2 = y1 == y2 && m1 == m2
  where
    (y1, m1, _) = toGregorian . localDay $ zonedTimeToLocalTime t1
    (y2, m2, _) = toGregorian . localDay $ zonedTimeToLocalTime t2