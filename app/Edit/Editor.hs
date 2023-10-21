module Edit.Editor
  ( getAvailableEditors,
    printAvailableEditors,
    setEditor,
    printCurrentEditor,
    isAvailableEditor,
    editFile,
  )
where

import qualified Config.Default as CD
import qualified Config.Editor as ConfEditor
import qualified Config.Exported as CE
import Control.Monad (filterM)
import Data.List (intercalate)
import Data.Maybe (isJust)
import qualified Printer.Print as Print
import System.Cmd (system)
import System.Directory (findExecutable)
import qualified Utils.Exec as Exec

-- Function returns the crossesection of editors that are prescribed in config
-- and editors that are installed on the current system
getAvailableEditors :: IO [String]
getAvailableEditors = filterM (fmap isJust . findExecutable) CD.editors

printAvailableEditors :: IO ()
printAvailableEditors = do
  editors <- getAvailableEditors
  Print.normalComment "Available editors:"
  let editorsString = intercalate "\t" editors
  Print.normalComment editorsString

setEditor :: String -> IO ()
setEditor chosenEditor = do
  availableEditors <- getAvailableEditors
  if chosenEditor `elem` availableEditors
    then do
      Print.normalComment $ "Default editor set to: " ++ chosenEditor
      ConfEditor.setEditor chosenEditor
    else do
      if chosenEditor == ""
        then Print.warningMessage "No editor selected"
        else Print.warningMessage $ "The editor `" ++ chosenEditor ++ "` is not available in your system"
      Print.warningMessage "Commands `edit` and `config` may be unavailable"
      printAvailableEditors

printCurrentEditor :: IO ()
printCurrentEditor = do
  let currentEditor = CE.editor
  availableEditors <- getAvailableEditors
  if currentEditor `elem` availableEditors
    then Print.normalComment $ "Editor: " ++ currentEditor
    else do
      Print.warningMessage $ "The editor `" ++ currentEditor ++ "` is not available in your system"
      Print.warningMessage "Commands `edit` and `config` may be unavailable"
      printAvailableEditors

isAvailableEditor :: String -> IO Bool
isAvailableEditor requestedEditor = do
  availableEditors <- getAvailableEditors
  return (requestedEditor `elem` availableEditors)

-- Function that takes filepath as input
-- it checks the current editor for validity
-- if the default editor is valid, then it opens the file in this editor
-- otherwise it informs that "Editing is not posppible with the current editor: " xxx
-- and does setEditor
editFile :: String -> IO ()
editFile filename = do
  let editor = CE.editor
  isAvailable <- isAvailableEditor editor
  if isAvailable
    then do
      Print.warningMessage $ "Opening " ++ filename ++ " in " ++ editor
      _ <- system $ editor ++ " " ++ filename
      return ()
    else do
      Print.warningMessage $ "The editor `" ++ editor ++ "` is not available in your system"
      Print.warningMessage "Commands `edit` and `config` may be unavailable"
      printAvailableEditors
      setEditor editor
