module Timestamp
  ( createTimestamp,
    timeDiffCasual,
    parseTimestamp,
    diffLocalTime,
  )
where

import Data.Time.Clock
import Data.Time.Format
import Data.Time.LocalTime hiding (diffLocalTime)

-- Create a timestamp in localtime, in the format YYYY-MM-DD HH:MM
createTimestamp :: IO String
createTimestamp = do
  now <- getZonedTime
  return $ formatTime defaultTimeLocale "%Y-%m-%d %H:%M" now

-- Calculate the time difference between two timestamps in YYYY-MM-DD HH:MM
timeDiffCasual :: String -> String -> String
timeDiffCasual ts1 ts2 = case (parseTimestamp ts1, parseTimestamp ts2) of
  (Just t1, Just t2) -> formatDiff $ diffLocalTime t1 t2
  _ -> ""

-- Parse a timestamp in the format YYYY-MM-DD HH:MM
parseTimestamp :: String -> Maybe LocalTime
parseTimestamp = parseTimeM True defaultTimeLocale "%Y-%m-%d %H:%M"

-- Calculate the difference between two LocalTime values and return as Integer
diffLocalTime :: LocalTime -> LocalTime -> Integer
diffLocalTime t1 t2 = round $ abs $ diffUTCTime (localTimeToUTC utc t1) (localTimeToUTC utc t2)

-- Format a time difference
formatDiff :: Integer -> String
formatDiff diff
  | diff < 60 = "< 1 min"
  | diff < 3600 = show (diff `div` 60) ++ " minutes"
  | diff < 14400 = show (diff `div` 3600) ++ " hours " ++ show ((diff `mod` 3600) `div` 60) ++ " minutes"
  | diff < 82800 = show (diff `div` 3600) ++ " hours"
  | otherwise = show (diff `div` 86400) ++ " days"
