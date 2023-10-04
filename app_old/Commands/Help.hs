module Commands.Help (printHelp) where

import FileManager (readFromFile)

printHelp :: [String] -> IO ()
printHelp [] = showDefaultHelp
printHelp (arg : _)
  | arg == "commands" = showCommandsHelp
  | otherwise = showDefaultHelp

showDefaultHelp :: IO ()
showDefaultHelp = do
  content <- readFromFile "app/texts/help_info.txt"
  putStrLn content

showCommandsHelp :: IO ()
showCommandsHelp = do
  content <- readFromFile "app/texts/help_commands.txt"
  putStrLn content
