module Commands.Shell where

import Commands.Commands as Commands
import Control.Monad (void)
import Control.Monad.IO.Class (liftIO)
import System.Console.Haskeline
import System.Process (system)

shellLoop :: IO ()
shellLoop = do
  putStrLn "\ESC[1;34m"
  putStrLn "DoDoDo shell"
  putStrLn ""
  putStrLn "'quit' to exit the shell"
  putStrLn "'clear' clear shell screen"
  putStrLn "<TAB> to autocomplete taskID"
  putStrLn "\ESC[m"
  runInputT defaultSettings loop
  where
    loop = do
      minput <- getInputLine "\ESC[1;34mDoDoDo>>> \ESC[m"
      case minput of
        Nothing -> return ()
        Just "quit" -> return ()
        Just "clear" -> do
          _ <- liftIO $ system "clear" -- On Unix-like systems
          loop
        Just input -> do
          liftIO $ Commands.processCommand (words input)
          loop
