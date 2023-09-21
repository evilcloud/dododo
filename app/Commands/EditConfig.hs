module Commands.EditConfig
  ( openConfig,
  )
where

import Commands.Editor (chooseEditor, getAvailableEditors, getDefaultEditor)
import System.Directory (doesFileExist)
import System.Process (callCommand)

-- -- Function to open the configuration file in the default editor
-- openConfig :: IO ()
-- openConfig = do
--   let configPath = "~/.config/dododo/config.yaml"
--   configExists <- doesFileExist configPath
--   if configExists
--     then do
--       editor <- getDefaultEditor
--       case editor of
--         Just ed -> callCommand (ed ++ " " ++ configPath)
--         Nothing -> do
--           chosenEditor <- chooseEditor
--           callCommand (chosenEditor ++ " " ++ configPath)
--     else putStrLn "Configuration file does not exist."

-- Function to open the configuration file in the default editor
openConfig :: IO ()
openConfig = do
  let configPath = "~/.config/dododo/config.yaml"
  editor <- getDefaultEditor
  case editor of
    Just ed -> callCommand (ed ++ " " ++ configPath)
    Nothing -> do
      chosenEditor <- chooseEditor
      callCommand (chosenEditor ++ " " ++ configPath)
