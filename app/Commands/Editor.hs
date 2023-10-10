module Commands.Editor
  ( getAvailableEditors,
    getDefaultEditor,
    chooseEditor,
  )
where

import Config.Config as Config
import qualified Config.IO as ConfigIO
import Control.Monad (filterM, forM_)
import Data.List (delete)
import Data.Maybe (isJust)
import System.Directory (findExecutable)
import System.Environment (lookupEnv)

-- Function to check if an editor is available
isAvailable :: FilePath -> IO Bool
isAvailable = fmap isJust . findExecutable

-- Function to get all available editors
getAvailableEditors :: IO [String]
getAvailableEditors = do
  let editors = ["vim", "ed", "nvim", "neovide", "nano", "emacs", "code", "subl", "atom"]
  filterM isAvailable editors

-- Function to get the default system editor
getDefaultEditor :: IO (Maybe String)
getDefaultEditor = lookupEnv "EDITOR"

-- Function to list available editors and ask the user to choose one
chooseEditor :: IO String
chooseEditor = do
  availableEditors <- getAvailableEditors
  defaultEditor <- getDefaultEditor
  let availableEditors' = case defaultEditor of
        Just de -> if de `elem` availableEditors then de : delete de availableEditors else availableEditors
        Nothing -> availableEditors
  case availableEditors' of
    [] -> error "No editors available."
    _ -> do
      putStrLn "Please choose an editor (default one is marked with *):"
      forM_ (zip [1 ..] availableEditors') $ \(i, editor) ->
        putStrLn $ show i ++ ". " ++ editor ++ if Just editor == defaultEditor then " *" else ""
      choice <- getLine
      let chosenEditor = availableEditors' !! (read choice - 1)
      ConfigIO.updateConfig "SETTINGS" "editor" chosenEditor
      putStrLn $ chosenEditor ++ " has been set as preferred editor"
      return chosenEditor
