module Commands.New
  ( newMicro,
    newTomorrow,
  )
where

import qualified New
import qualified Printer.Forms as PF

-- import qualified Printer.Colors as Colors

newMicro :: [String] -> IO ()
newMicro [] = putStrLn "No task provided"
newMicro args
  | last args == "help" = do
      -- Colors.blue ["do <message>", "", "create a new micro task"]
      putStrLn "do <message> or <help>"
      putStrLn ""
      -- putStrLn "creates a new micro task"
      PF.normalComment "creates a new micro task"
  | otherwise = New.createNewMicro $ unwords args

newTomorrow :: [String] -> IO ()
newTomorrow [] = putStrLn "No task provided"
newTomorrow args
  | last args == "help" = putStrLn "Help for newTomorrow: ..."
  | otherwise = New.createNewTomorrow $ unwords args
