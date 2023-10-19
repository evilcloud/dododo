module Help.AllCommands (printAvailableCommands) where

import Data.List (intercalate)
import qualified Data.Map as Map
import qualified Printer.Print as Print

type Commands = [String]

availableCommands :: Map.Map String Commands
availableCommands =
  Map.fromList
    [ ( "Task related",
        ["do", "done", "undone", "delete", "tomorrow", "today", "yesterday"]
      ),
      ( "Config related",
        ["config", "lifetime", "reset"]
      )
    ]

printAvailableCommands :: IO ()
printAvailableCommands = do
  Print.helpMessage "Available commands:"
  mapM_ printCommand $ Map.toList availableCommands
  Print.helpMessage
    [ "For more information about a command, type:",
      "dododo help <command>",
      "or",
      "<command> help"
    ]
  where
    printCommand (key, commands) = do
      Print.helpMessage $ key ++ ":"
      let commandsStr = intercalate "\t" commands
      Print.normalComment commandsStr
