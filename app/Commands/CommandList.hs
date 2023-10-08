module Commands.CommandList where

import qualified Commands.Delete as Delete
import qualified Commands.Done as Done
import qualified Commands.Edit as Edit
import qualified Commands.EditConfig as EditConfig
import qualified Commands.Editor as Editor
import qualified Commands.Help as Help
import qualified Commands.New as New
import qualified Commands.Sync as Sync
import qualified Commands.Undone as Undone
import qualified Commands.Unknown as Unknown
import qualified Config.Config as Config
import Control.Monad (void)
import qualified Data.Map as M
import Data.Maybe (fromMaybe)
import qualified FindTask
import System.IO (hFlush, stdout)
import qualified TasksArray.List as List

-- processCommand :: [String] -> IO ()
-- processCommand [] = List.allStdOut
-- processCommand (command : args) = do
--   putStrLn "\n"
--   let options = fromMaybe [] (M.lookup command Config.commandOptions)
--   let matchOption x = x `elem` options
--   void $ case command of
--     x | matchOption x ->
--       case command of
--         "new" -> New.commandNew args
--         "task" -> FindTask.findAndPrintTaskById (head args)
--         "done" -> Done.commandDone args
--         "undone" -> Undone.commandUndone args
--         "delete" -> Delete.commandDelete args
--         "help" -> Help.printHelp args
--         "editor" -> void Editor.chooseEditor
--         "config" -> EditConfig.openConfig
--         "edit" -> Edit.commandEdit args
--         "sync" -> Sync.syncCommand args
--         _ -> Unknown.handleUnknownCommand
--     _ -> Unknown.handleUnknownCommand
--   putStrLn "\n"

processCommand :: [String] -> IO ()
processCommand [] = List.allStdOut
processCommand (command : args) = do
  putStrLn "\n"
  void $ case command of
    "new" -> New.commandNew args
    "task" -> FindTask.findAndPrintTaskById (head args)
    "done" -> Done.commandDone args
    "undone" -> Undone.commandUndone args
    "delete" -> Delete.commandDelete args
    "help" -> Help.printHelp args
    "editor" -> void Editor.chooseEditor
    "config" -> EditConfig.openConfig
    "edit" -> Edit.commandEdit args
    "sync" -> Sync.syncCommand args
    _ -> Unknown.handleUnknownCommand
  putStrLn "\n"
