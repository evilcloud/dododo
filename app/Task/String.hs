{-# LANGUAGE RecordWildCards #-}

module Task.String
  ( toDisplayString,
    toSaveString,
    toSimpleString,
  )
where

import Data.Time
import Data.Time.LocalTime (getCurrentTimeZone, utcToLocalTime)
import Task.Model

type TimeFormatter = UTCTime -> IO String

type BaseStringFunction a = TimeFormatter -> String -> a -> IO String

class Stringify a where
  toDisplayString :: a -> IO String
  toSaveString :: a -> IO String
  toSimpleString :: a -> IO String

toLocalTime :: UTCTime -> IO LocalTime
toLocalTime utcTime = do
  tz <- getCurrentTimeZone
  return $ utcToLocalTime tz utcTime

timeForDisplay :: TimeFormatter
timeForDisplay utcTime = do
  localTime <- toLocalTime utcTime
  return $ formatTime defaultTimeLocale "%Y-%m-%d %H:%M" localTime

timeForSave :: TimeFormatter
timeForSave utcTime = do
  localTime <- toLocalTime utcTime
  return $ formatTime defaultTimeLocale "%Y-%m-%d %H:%M" localTime

timeForSaveDateOnly :: TimeFormatter
timeForSaveDateOnly utcTime = do
  localTime <- toLocalTime utcTime
  return $ formatTime defaultTimeLocale "%Y-%m-%d" localTime

baseMicroString :: BaseStringFunction Micro
baseMicroString formatTimeFn separator Micro {..} = do
  timeStr <- formatTimeFn creation
  return $
    " "
      ++ timeStr
      ++ separator
      ++ taskId
      ++ separator
      ++ message
      ++ (if status /= "" then separator ++ status ++ " @" ++ duration else "")

baseTomorrowString :: BaseStringFunction Tomorrow
baseTomorrowString formatTimeFn separator tomorrow@(Tomorrow {..}) = do
  timeStr <- formatTimeFn creation
  return $
    " "
      ++ (if isDone then "[x]" else "[ ]")
      ++ separator
      ++ taskId
      ++ separator
      ++ message

-- Separators
separatorSymbol :: String
separatorSymbol = "  |  "

separatorSpace :: String
separatorSpace = "  "

-- Helper function for Stringify instances
baseStringify :: BaseStringFunction a -> a -> IO String
baseStringify baseFn = baseFn timeForDisplay separatorSymbol

-- Micro related functions
instance Stringify Micro where
  toDisplayString = baseStringify baseMicroString
  toSaveString = baseMicroString timeForSave separatorSymbol
  toSimpleString = baseStringify baseMicroString

-- Tomorrow related functions
instance Stringify Tomorrow where
  toDisplayString = baseStringify baseTomorrowString
  toSaveString = baseTomorrowString timeForSaveDateOnly separatorSymbol
  toSimpleString = baseStringify baseTomorrowString

-- Task related functions
instance Stringify Task where
  toDisplayString (MicroTask micro) = toDisplayString micro
  toDisplayString (TomorrowTask tomorrow) = toDisplayString tomorrow
  toSaveString (MicroTask micro) = toSaveString micro
  toSaveString (TomorrowTask tomorrow) = toSaveString tomorrow
  toSimpleString (MicroTask micro) = toSimpleString micro
  toSimpleString (TomorrowTask tomorrow) = toSimpleString tomorrow
