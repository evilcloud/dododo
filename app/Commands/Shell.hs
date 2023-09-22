module Commands.Shell where

import Commands.CommandList (processCommand)
import Control.Monad.IO.Class (liftIO)
import Data.List (isPrefixOf)
import System.Console.Haskeline
import System.Console.Haskeline.Completion
import qualified TasksIO

mySettings :: [String] -> Settings IO
mySettings taskIds =
  Settings
    { complete = myCompleter taskIds,
      historyFile = Nothing,
      autoAddHistory = True
    }

myCompleter :: [String] -> CompletionFunc IO
myCompleter taskIds = completeWord Nothing " \t" $ \str -> return (map simpleCompletion $ filter (str `isPrefixOf`) taskIds)

shellLoop :: IO ()
shellLoop = do
  putStrLn "\ESC[1;34m"
  putStrLn "DoDoDo shell"
  putStrLn ""
  putStrLn "'quit' to exit the shell"
  putStrLn "<TAB> to autocomplete taskID"
  putStrLn "\ESC[m"
  taskIds <- TasksIO.getAllTaskIds
  runInputT (mySettings taskIds) loop
  where
    loop = do
      minput <- getInputLine "\ESC[1;34mDoDoDo>>> \ESC[m"
      case minput of
        Nothing -> return ()
        Just "quit" -> return ()
        Just input -> do
          liftIO $ processCommand (words input)
          loop
