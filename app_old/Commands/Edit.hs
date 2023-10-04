module Commands.Edit
  ( editTaskFile,
  )
where

import qualified Commands.Editor as Editor
import qualified Config
import System.Process (callCommand)

-- Function to edit a task file with a specified editor or the default editor
editTaskFile :: [String] -> IO ()
editTaskFile args = do
  chosenEditor <- case args of
    (editor : _) -> return editor
    [] -> do
      defaultEditor <- Editor.getDefaultEditor
      case defaultEditor of
        Just de -> return de
        Nothing -> Editor.chooseEditor
  callCommand $ chosenEditor ++ " " ++ Config.current
