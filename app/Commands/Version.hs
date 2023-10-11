module Commands.Version (commandVersion) where

commandVersion :: [String] -> IO ()
commandVersion _ = putStrLn "DoDoDo - version 0.2.0.0"
