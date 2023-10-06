-- Commands/Delete.hs
module Commands.Delete (commandDelete) where

import qualified Task.Delete as Delete

commandDelete :: [String] -> IO ()
commandDelete [] = putStrLn "No task IDs provided - nothing deleted"
commandDelete taskIds = Delete.deleteTasks taskIds
