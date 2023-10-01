module Commands.CommandList where

import qualified Commands.Delete as Delete
import qualified Commands.Done as Done
import qualified Commands.Edit as Edit
import qualified Commands.EditConfig as EditConfig
import qualified Commands.Editor as Editor
import qualified Commands.Help as Help
import qualified Commands.ListTasks as ListTasks
import qualified Commands.New as New
import qualified Commands.Sync as Sync
import qualified Commands.Undone as Undone
import qualified Commands.Unknown as Unknown
import qualified Config
import Control.Monad (void)
import qualified Data.Map as M
import Data.Maybe (fromMaybe)
import qualified FindTask
import System.IO (hFlush, stdout)

processCommand :: [String] -> IO ()
processCommand [] = ListTasks.allStdOut
processCommand (command : args) = do
  putStrLn "\n"
  let options = fromMaybe [] (M.lookup command Config.commandOptions)
  let matchOption x = x `elem` options
  case command of
    x | matchOption x ->
      case command of
        "new" -> void $ New.new (unwords args)
        "task" -> FindTask.findAndPrintTaskById (head args)
        "done" -> Done.doneCommand args
        "undone" -> Undone.undoneCommand args
        "delete" -> Delete.deleteTasks args
        "help" -> Help.printHelp args
        "editor" -> void Editor.chooseEditor
        "config" -> void EditConfig.openConfig
        "edit" -> Edit.editTaskFile args
        "sync" -> Sync.syncCommand args
        _ -> Unknown.handleUnknownCommand
    _ -> Unknown.handleUnknownCommand
  putStrLn "\n"