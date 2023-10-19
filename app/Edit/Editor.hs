module Edit.Editor
  ( getDefaultEditor,
    choseEditor,
    printCurrentEditor,
  )
where

import qualified Config.Default as CD
import qualified Config.Editor as ConfEditor
import qualified Config.Exported as CE
import qualified Config.IO as CIO
import Control.Monad (filterM, forM_)
import Data.Maybe (isJust)
import System.Directory (findExecutable)

possibleEditors :: [String]
possibleEditors = CD.editors

availableEditors :: IO [String]
availableEditors = filterM (fmap isJust . findExecutable) possibleEditors

currentEditor :: String
currentEditor = CE.editor

-- Function to let the user chose an editor from the list of available ones
choseEditor :: IO ()
choseEditor = do
  editors <- availableEditors
  putStrLn "Available editors:"
  forM_ (zip [1 ..] editors) $ \(i, editor) -> do
    putStrLn $ show i ++ ". " ++ editor
  putStrLn "Please choose an editor:"
  choice <- getLine
  let choiceInt = read choice :: Int
  if choiceInt > 0 && choiceInt <= length editors
    then do
      let chosenEditor = editors !! (choiceInt - 1)
      putStrLn $ "You chose " ++ chosenEditor ++ "."
      ConfEditor.setEditor chosenEditor
    else do
      putStrLn "Invalid choice. Please try again."
      choseEditor

-- Function to return the default editor, if there is a defaul editor, that is also available editor
-- If there is no such editor, then chosEditor and try again
getDefaultEditor :: IO String
getDefaultEditor = do
  let defaultEditor = CE.editor
  isAvailable <- isJust <$> findExecutable defaultEditor
  if isAvailable
    then return defaultEditor
    else do
      putStrLn "Default editor is not available. Please choose an editor:"
      choseEditor
      getDefaultEditor

printCurrentEditor :: IO ()
printCurrentEditor = do
  editor <- getDefaultEditor
  putStrLn $ "Editor: " ++ editor
