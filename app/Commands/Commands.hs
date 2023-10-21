module Commands.Commands where

import qualified Commands.Editor as Editor
import qualified Commands.Help as Help
import qualified Commands.Lifetime as Lifetime
import qualified Commands.List as List
import qualified Commands.New as New
import qualified Commands.Reset as Reset
import qualified Commands.Unknown as Unknown
import Control.Monad (void)
import Data.Maybe (listToMaybe)
import qualified Task.Status as Status

processCommand :: [String] -> IO ()
processCommand [] = List.commandList []
processCommand (command : args)
  | listToMaybe args == Just "help" = Help.commandHelp [command]
  | otherwise = void $ case command of
      "do" -> New.newMicro args
      "new" -> New.newMicro args
      "tomorrow" -> New.newTomorrow args
      "reset" -> Reset.resetConfig args
      "lifetime" -> Lifetime.lifetime args
      "help" -> Help.commandHelp args
      "editor" -> Editor.commandEditor args
      "edit" -> Editor.commandEdit args
      "config" -> Editor.commandConfig args
      "list" -> List.commandList args
      "today" -> List.commandToday args
      _ -> Unknown.unknown (command : args)
