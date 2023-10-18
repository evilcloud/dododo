module Collection.Parser where

import Control.Monad (guard)
import Data.List.Split (splitOn)
import Data.Maybe (listToMaybe)
import Data.Time.Format (defaultTimeLocale, parseTimeOrError)
import Task.Model (Micro (..), Task (..), Tomorrow (..))

parseTask :: String -> Maybe Task
parseTask str
  | isMicro str = MicroTask <$> parseMicro str
  | otherwise = TomorrowTask <$> parseTomorrow str
  where
    isMicro = (== ' ') . head -- assuming Micro tasks start with a space
    parseMicro s = do
      let parts = splitOn "  |  " s
      guard (length parts == 5)
      let [_, timeStr, taskId, message, status] = parts
          time = parseTimeOrError True defaultTimeLocale "%Y-%m-%d %H:%M" timeStr
      return Micro {creation = time, taskId = taskId, message = message, status = status, duration = 0}
    parseTomorrow s = do
      let parts = splitOn "  |  " s
      guard (length parts == 4)
      let [_, checkbox, taskId, message] = parts
          time = parseTimeOrError True defaultTimeLocale "%Y-%m-%d" taskId
          done = checkbox == "[x]"
      return Tomorrow {isDone = done, taskId = taskId, creation = time, message = message}
