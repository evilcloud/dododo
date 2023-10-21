{-# LANGUAGE DuplicateRecordFields #-}

module Task.Parser where

import Data.Char (isSpace)
import Data.List.Split (splitOn)
import Data.Maybe (isJust)
import Data.Time.Clock (UTCTime)
import Data.Time.Format (defaultTimeLocale, parseTimeM)
import Task.Model (Micro (..), Status (..), Task (..), Tomorrow (..))

sanitize :: String -> String
sanitize = dropWhile isSpace . reverse . dropWhile isSpace . reverse

parseTask :: String -> Maybe Task
parseTask str =
  let parts = map sanitize $ splitOn "  |  " str
   in if isMicro parts
        then MicroTask <$> parseMicro parts
        else TomorrowTask <$> parseTomorrow parts
  where
    isMicro = isJust . (parseTimeM True defaultTimeLocale "%Y-%m-%d %H:%M" :: String -> Maybe UTCTime) . head
    parseMicro [dateTimeStr, taskId, message, statusDuration] = do
      time <- parseTimeM True defaultTimeLocale "%Y-%m-%d %H:%M" dateTimeStr
      let (status, duration) =
            if null statusDuration
              then ("", "")
              else case splitOn "@" statusDuration of
                [s, d] -> (sanitize s, sanitize d)
                _ -> ("", "")
      return Micro {creation = time, taskId = taskId, message = message, status = status, duration = duration}
    parseMicro [dateTimeStr, taskId, message] = do
      time <- parseTimeM True defaultTimeLocale "%Y-%m-%d %H:%M" dateTimeStr
      return Micro {creation = time, taskId = taskId, message = message, status = "", duration = ""}
    parseMicro _ = Nothing
    parseTomorrow [checkbox, taskId, message] = do
      time <- parseTimeM True defaultTimeLocale "%Y-%m-%d" taskId
      let done = if checkbox == "[x]" then Done else Undone
      return Tomorrow {isDone = done, taskId = taskId, creation = time, message = message}
    parseTomorrow _ = Nothing
