module Commands.Commands where

import qualified Commands.New as New
import qualified Commands.TestTask as TestTask
import Control.Monad (void)

processCommand :: [String] -> IO ()
processCommand [] = putStrLn "No task provided"
processCommand (command : args) = void $ case command of
  "testtask" -> TestTask.test
  "new" -> New.newTask args
  _ -> unknown

unknown :: IO ()
unknown = putStrLn "Unknown command"
