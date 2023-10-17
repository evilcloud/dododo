module Commands.Commands where

import qualified Commands.New as New
import Control.Monad (void)

processCommand :: [String] -> IO ()
processCommand [] = putStrLn "No task provided"
processCommand (command : args) = void $ case command of
  "do" -> New.newMicro args
  "tomorrow" -> New.newTomorrow args
  _ -> unknown

unknown :: IO ()
unknown = putStrLn "Unknown command"
