module Commands.Edit where

import qualified Commands.Editor as Editor
import qualified Config.Config as Config
import System.Process (callCommand)

-- Function to edit a task file using the default editor
editTaskFile :: [String] -> IO ()
editTaskFile _ = do
  editorResult <- Editor.getDefaultEditor
  config <- Config.getConfig
  let currentFilePathResult = Config.configFilePath
  case currentFilePathResult of
    Right currentFilePath -> case editorResult of
      Just editor -> System.Process.callCommand $ editor ++ " " ++ currentFilePath
      Nothing -> putStrLn "No editor set"
    _ -> return () -- Do nothing if currentFilePathResult is Left

-- Function to open a file in a given editor
openFileInEditor :: String -> String -> IO ()
openFileInEditor editor fileName = callCommand $ editor ++ " " ++ fileName
