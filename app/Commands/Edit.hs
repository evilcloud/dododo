module Commands.Edit (commandEdit) where

import qualified Handlers.Edit as Edit

commandEdit :: [String] -> IO ()
commandEdit (editor : _) = Edit.editTask (Just editor)
commandEdit [] = Edit.editTask Nothing
