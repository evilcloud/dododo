-- module Commands.Edit
--   ( editTaskFile,
--   )
-- where

-- import qualified Commands.Editor as Editor
-- import qualified Config.Config as Config
-- import Control.Monad (void)
-- import Data.ConfigFile (CPError, emptyCP, get, readstring)
-- import Data.Maybe (isNothing)
-- import System.Process (callCommand)

-- -- Function to edit a task file with a specified editor or the default editor
-- editTaskFile :: [String] -> IO ()
-- editTaskFile args = do
--   chosenEditor <- case args of
--     (editor : _) -> return editor
--     [] -> Editor.getDefaultEditor
--   config <- Config.getConfig
--   let taskFilePathResult = get config "PATHS" "current"
--   case taskFilePathResult of
--     Left _ -> putStrLn "Error: Could not get task file path from configuration."
--     Right taskFilePath -> callCommand $ chosenEditor ++ " " ++ taskFilePath

module Commands.Edit where

-- Add this line
import qualified Commands.Editor as Editor
import qualified Config.Config as Config
import System.Process (callCommand)

-- Function to edit a task file using the default editor
editTaskFile :: [String] -> IO ()
editTaskFile _ = do
  editorResult <- Editor.getDefaultEditor
  config <- Config.getConfig
  let currentFilePathResult = Config.get config "PATHS" "current"
  case currentFilePathResult of
    Right currentFilePath -> case editorResult of
      Just editor -> System.Process.callCommand $ editor ++ " " ++ currentFilePath
      Nothing -> putStrLn "No editor set"
    _ -> return () -- Do nothing if currentFilePathResult is Left

-- Function to open a file in a given editor
openFileInEditor :: String -> String -> IO ()
openFileInEditor editor fileName = callCommand $ editor ++ " " ++ fileName
