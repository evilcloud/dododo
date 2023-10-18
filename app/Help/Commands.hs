module Help.Commands (getHelp) where

import Data.Map (Map)
import qualified Data.Map as Map
import qualified Printer.Print as Print

type CommandHelp = [String]

commands :: Map String CommandHelp
commands =
  Map.fromList
    [ ( "do",
        [ "do <message>",
          "",
          "create a new micro task"
        ]
      ),
      ( "tomorrow",
        [ "tomorrow <message>",
          "",
          "create a new todo task with 1 day lifetime"
        ]
      ),
      ( "shell",
        [ "shell",
          "",
          "a small shell, that may help focusing on the tasks without having to enter dododo all the time"
        ]
      ),
      ( "reset",
        [ "reset",
          "",
          "reset the config.ini file to default settings"
        ]
      ),
      ( "lifetime",
        [ "lifetime [number of days]",
          "",
          "if no arguments are provided `lifetime` will display the lifetime of micro tasks as per config",
          "if a number is provided, `lifetime` will set this number as the lifetime in days in the config"
        ]
      ),
      ( "help",
        [ "help <command>",
          "\t or",
          "<command> help",
          "",
          "a brief help instruction for a given command"
        ]
      )
    ]

getHelp :: String -> IO ()
getHelp cmd = case Map.lookup cmd commands of
  Just helpText -> Print.helpMessage helpText
  Nothing -> Print.warningMessage $ "Help: command `" ++ cmd ++ "` not found."
