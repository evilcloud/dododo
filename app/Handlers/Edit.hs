module Handlers.Edit (editTask) where

import qualified Commands.Editor as Editor
import qualified Config.Config as Config
import System.Process (callCommand)

--editTask :: Maybe String -> IO ()
--editTask (Just editor) = callCommand $ editor ++ " " ++ Config.current
--editTask Nothing = do
--  let editor = Config.editor
--  if null editor
--    then do
--      chosenEditor <- Editor.chooseEditor
--      callCommand $ chosenEditor ++ " " ++ Config.current
--    else callCommand $ editor ++ " " ++ Config.current

editTask :: Maybe String -> IO ()
editTask (Just editor) = callCommand $ editor ++ " " ++ Config.current
editTask Nothing = do
  editor <- Config.editor
  if null editor
    then do
      chosenEditor <- Editor.chooseEditor
      callCommand $ chosenEditor ++ " " ++ Config.current
    else callCommand $ editor ++ " " ++ Config.current
