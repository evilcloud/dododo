module Task.Format 
    (taskForFile
    , taskForPrint)
    where

import Data.Time
import Data.Time.Clock (NominalDiffTime, diffUTCTime)
import Data.Time.Format (formatTime, defaultTimeLocale)
import Data.Time.LocalTime (LocalTime, localTimeToUTC, utc)
import Data.Maybe (fromMaybe)
import qualified Task.Task as Task

separator :: String
separator = "  |  "

todoChecked :: String
todoChecked = "[x]"

todoUnchecked :: String
todoUnchecked = "[ ]"

timestampToString :: LocalTime -> String
timestampToString = formatTime defaultTimeLocale "%Y-%m-%d %H:%M"

formatDiff :: NominalDiffTime -> String
formatDiff diff
  | seconds < 60 = "< 1 min"
  | seconds < 3600 = show (seconds `div` 60) ++ " min"
  | seconds < 86400 = show (seconds `div` 3600) ++ " hours"
  | otherwise = show (seconds `div` 86400) ++ " days"
  where seconds = floor diff :: Integer

formatMicroTask :: Task.Task -> String -> String
formatMicroTask task timestamp = 
  case task of
    Task.MicroTask {Task.taskId = id, Task.message = message, Task.status = status, Task.duration = duration} -> 
      let statusStr = fromMaybe "" status
          durationStr = maybe "" formatDiff duration
      in case status of
           Nothing -> timestamp ++ separator ++ id ++ separator ++ message
           Just _  -> timestamp ++ separator ++ id ++ separator ++ message ++ separator ++ statusStr ++ "@" ++ durationStr
    _ -> ""


formatTomorrowTask :: Task.Task -> String
formatTomorrowTask task = 
  case task of
    Task.TomorrowTask {Task.todoChecked = isChecked, Task.taskId = id, Task.message = message} ->
      let prefix = if isChecked then todoChecked else todoUnchecked
      in prefix ++ "   " ++ id ++ separator ++ message
    _ -> ""

taskForFile :: Task.Task -> IO String
taskForFile task = 
  case task of
    microTask@Task.MicroTask {} -> do
      let creation = timestampToString $ Task.creation microTask
      return $ formatMicroTask task creation
    tomorrowTask@Task.TomorrowTask {} -> return $ formatTomorrowTask task


taskForPrint :: Task.Task -> IO String
taskForPrint task = do
  case task of
    microTask@Task.MicroTask {} -> do
      creation <- casualTime $ Task.creation microTask
      return $ formatMicroTask task creation
    tomorrowTask@Task.TomorrowTask {} -> return $ formatTomorrowTask task

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
