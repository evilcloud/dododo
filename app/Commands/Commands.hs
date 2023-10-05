module Commands.Commands where

import qualified Commands.Edit as Edit
import qualified Commands.Editor as Editor
import qualified Commands.New as New
import qualified Commands.TestTask as TestTask
import Control.Monad (void)

processCommand :: [String] -> IO ()
processCommand [] = putStrLn "No task provided"
processCommand (command : args) = void $ case command of
  "new" -> New.newTask args
  "edit" -> Edit.editTaskFile args
  "editor" -> void Editor.chooseEditor
  _ -> unknown

unknown :: IO ()
unknown = putStrLn "Unknown command"
