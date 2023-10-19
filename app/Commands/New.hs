module Commands.New
  ( newMicro,
    newTomorrow,
  )
where

import qualified Help.Commands as Help
import qualified Printer.Print as Print
import qualified Task.New as New

newMicro :: [String] -> IO ()
newMicro [] = Print.warningMessage "No task provided"
newMicro args = New.createNewMicro $ unwords args

newTomorrow :: [String] -> IO ()
newTomorrow [] = Print.warningMessage "No task provided"
newTomorrow args = New.createNewTomorrow $ unwords args
