module Commands.Shell where

import Commands.CommandList (processCommand)
import System.IO (hFlush, stdout)

shellLoop :: IO ()
shellLoop = do
  putStr "DoDoDo> "
  hFlush stdout
  command <- getLine
  if command == "quit"
    then return ()
    else do
      processCommand (words command)
      shellLoop
