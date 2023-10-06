-- Commands/Done.hs
module Commands.Done (commandDone) where

import qualified Task.Done as Done

commandDone :: [String] -> IO ()
commandDone args = case args of
  [] -> Done.closeLatestOpenTask "done"
  [taskId] -> Done.changeStatus taskId "done"
  (taskId : newStatus : _) -> Done.changeStatus taskId newStatus
