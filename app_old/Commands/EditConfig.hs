module Commands.EditConfig
  ( openConfig,
  )
where

import Commands.Editor (chooseEditor, getAvailableEditors, getDefaultEditor)
import System.Directory (doesFileExist)
import System.Process (callCommand)

openConfig :: IO ()
openConfig = do
  let configPath = "~/.config/dododo/config.yaml"
  editor <- getDefaultEditor
  case editor of
    Just ed -> callCommand (ed ++ " " ++ configPath)
    Nothing -> do
      chosenEditor <- chooseEditor
      callCommand (chosenEditor ++ " " ++ configPath)
