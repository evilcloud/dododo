module Handlers.Edit
  ( editTask,
    editConfig,
  )
where

import qualified Commands.Editor as Editor
import qualified Config.Config as Config
import System.Process (callCommand)

editTask :: Maybe String -> IO ()
editTask (Just editor) = callCommand $ editor ++ " " ++ Config.current
editTask Nothing = do
  editor <- Config.editor
  if null editor
    then do
      chosenEditor <- Editor.chooseEditor
      callCommand $ chosenEditor ++ " " ++ Config.current
    else callCommand $ editor ++ " " ++ Config.current

editConfig :: Maybe String -> IO ()
editConfig (Just editor) = callCommand $ editor ++ " " ++ Config.configFilePath
editConfig Nothing = do
  editor <- Config.editor
  if null editor
    then do
      chosenEditor <- Editor.chooseEditor
      callCommand $ chosenEditor ++ " " ++ Config.configFilePath
    else callCommand $ editor ++ " " ++ Config.configFilePath
