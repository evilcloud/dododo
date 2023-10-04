module Commands.Unknown where

import Data.List (intercalate)

validCommands :: [String]
validCommands = ["new", "done", "undone", "delete", "help info", "help commands", "editor", "edit [editor]"]

handleUnknownCommand :: IO ()
handleUnknownCommand = do
  putStrLn "Unknown command"
  putStrLn "\ESC[1;34m"
  putStrLn $ intercalate "\t" validCommands
  putStrLn "\ESC[m"
