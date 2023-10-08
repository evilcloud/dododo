module Commands.New (commandNew) where

import qualified Task.New as New

commandNew :: [String] -> IO ()
commandNew [] = putStrLn "No task message provided - nothing created"
commandNew (message : _) = New.new message
