module Handlers.Edit (editTask) where

import qualified Commands.Editor as Editor
import Config
import System.Process (callCommand)

editTask :: Maybe String -> IO ()
editTask (Just editor) = callCommand $ editor ++ " " ++ Config.current
editTask Nothing = do
  defaultEditor <- Editor.getDefaultEditor
  case defaultEditor of
    Just de -> callCommand $ de ++ " " ++ Config.current
    Nothing -> do
      chosenEditor <- Editor.chooseEditor
      callCommand $ chosenEditor ++ " " ++ Config.current
