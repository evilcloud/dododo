module Commands.Editor where

import qualified Edit.Editor as Editor
import qualified Help.Commands as Help

editor :: [String] -> IO ()
editor [] = Editor.showDefaultEditor
editor args = Editor.chooseEditor args
