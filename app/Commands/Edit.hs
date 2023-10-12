module Commands.Edit
  ( commandEdit,
    commandConfig,
  )
where

import qualified Handlers.Edit as Edit

commandEdit :: [String] -> IO ()
commandEdit (editor : _) = Edit.editTask (Just editor)
commandEdit [] = Edit.editTask Nothing

commandConfig :: [String] -> IO ()
commandConfig (editor : _) = Edit.editConfig (Just editor)
commandConfig [] = Edit.editConfig Nothing
