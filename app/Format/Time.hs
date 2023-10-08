-- Format/Time.hs
module Format.Time
  ( formatTimestamp,
    formatDiff,
  )
where

import Data.Time.Clock (NominalDiffTime)
import Data.Time.Format (defaultTimeLocale, formatTime)
import Data.Time.LocalTime (LocalTime, localTimeToUTC, utc)

formatTimestamp :: LocalTime -> String
formatTimestamp = formatTime defaultTimeLocale "%Y-%m-%d %H:%M"

formatDiff :: NominalDiffTime -> String
formatDiff diff
  | seconds < 60 = "< 1 min"
  | seconds < 3600 = show (seconds `div` 60) ++ " min"
  | seconds < 86400 = show (seconds `div` 3600) ++ " hours"
  | otherwise = show (seconds `div` 86400) ++ " days"
  where
    seconds = floor diff :: Integer

casualTime :: LocalTime -> IO String
casualTime timestamp = do
  rawCurrentTime <- getZonedTime
  let daysDiff = diffDays (localDay $ zonedTimeToLocalTime rawCurrentTime) (localDay timestamp)
  let timeStr = formatTime defaultTimeLocale "%H:%M" timestamp
  return $ case daysDiff of
    0 -> "today " ++ timeStr
    1 -> "yesterday " ++ timeStr
    _ | daysDiff < 7 -> formatTime defaultTimeLocale "%a %H:%M" timestamp
    _ -> formatTime defaultTimeLocale "%d %b" timestamp
