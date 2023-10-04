module Commands.New (newTask) where

import qualified New.New as New

newTask :: [String] -> IO ()
newTask [] = putStrLn "No task provided"
newTask args = New.createNewTask args
