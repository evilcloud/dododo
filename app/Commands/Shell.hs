module Commands.Shell where

import Commands.Commands as Commands
import Control.Monad (void)
import Control.Monad.IO.Class (liftIO)
import qualified Printer.Print as Print
import System.Console.Haskeline
import System.Process (system)

shellLoop :: IO ()
shellLoop = do
  Print.normalComment
    [ "DoDoDo shell",
      "",
      "'quit' to exit the shell",
      "'clear' clear shell screen",
      "<TAB> to autocomplete taskID"
    ]

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
