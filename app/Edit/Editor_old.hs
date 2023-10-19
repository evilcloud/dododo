module Edit.Editor
  ( getAvailableEditors,
    setDefaultEditor,
    getDefaultEditor,
    chooseEditor,
  )
where

import qualified Config.Config as Config
import qualified Config.Default as CD
import Control.Monad (filterM, forM_, void)
import Data.Either (either)
import Data.Maybe (isJust)
import System.Directory (findExecutable)

-- List of possible editors
possibleEditors :: [String]
possibleEditors = ["vim", "ed", "nvim", "neovide", "nano", "emacs", "code", "subl", "atom"]

-- Function to check if an editor is available
isAvailable :: FilePath -> IO Bool
isAvailable = fmap isJust . findExecutable

-- Function to get all available editors from the list of possible ones
getAvailableEditors :: IO [String]
getAvailableEditors = filterM isAvailable possibleEditors

-- Function to set the default editor from the list of available ones and record it into config
setDefaultEditor :: IO ()
setDefaultEditor = do
  config <- Config.getConfig
  let defaultEditorResult = Config.configFilePath
  case defaultEditorResult of
    Right defaultEditor ->
      if defaultEditor `elem` possibleEditors
        then return ()
        else chooseEditor
    Left _ -> chooseEditor

-- Function to check for a default editor. If there is a default editor, then return that.
-- If not, make a choice with the function above, then return.
getDefaultEditor :: IO (Maybe String)
getDefaultEditor = do
  config <- Config.getConfig
  let defaultEditorResult = Config.get config "SETTINGS" "editor"
  case defaultEditorResult of
    Right defaultEditor ->
      if null defaultEditor || not (defaultEditor `elem` possibleEditors)
        then do
          putStrLn "No valid default editor set. Please choose an editor:"
          setDefaultEditor
          newConfig <- Config.getConfig
          let newDefaultEditorResult = Config.get newConfig "SETTINGS" "editor"
          return $ case newDefaultEditorResult of
            Right editor -> Just editor
            Left _ -> Nothing
        else return $ Just defaultEditor
    Left _ -> do
      putStrLn "No default editor set. Please choose an editor:"
      setDefaultEditor
      newConfig <- Config.getConfig
      let newDefaultEditorResult = Config.get newConfig "SETTINGS" "editor"
      return $ case newDefaultEditorResult of
        Right editor -> Just editor
        Left _ -> Nothing

-- Function to let the user choose an editor from the list of available ones
chooseEditor :: IO ()
chooseEditor = do
  availableEditors <- getAvailableEditors
  putStrLn "Please choose an editor:"
  forM_ (zip [1 ..] availableEditors) $ \(i, editor) ->
    putStrLn $ show i ++ ". " ++ editor
  choice <- getLine
  if null choice || read choice < 1 || read choice > length availableEditors
    then do
      putStrLn "Invalid choice. Please try again."
      setDefaultEditor
    else do
      let chosenEditor = availableEditors !! (read choice - 1)
      void $ Config.updateConfig "SETTINGS" "editor" chosenEditor
