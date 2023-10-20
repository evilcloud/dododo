module Commands.Editor
  ( commandEditor,
    commandEdit,
    commandConfig,
  )
where

import qualified Edit.Edit as Edit
import qualified Edit.Editor as Editor

commandEditor :: [String] -> IO ()
commandEditor [] = Editor.printCurrentEditor
commandEditor (editor : _) = Editor.setEditor editor

commandEdit :: [String] -> IO ()
commandEdit _ = Edit.editCurrent

commandConfig :: [String] -> IO ()
commandConfig _ = Edit.editConfig