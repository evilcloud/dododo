module Commands.Help (commandHelp) where

import Control.Monad (unless)
import qualified Help.Commands as Help
import qualified Printer.Print as Print

commandHelp :: [String] -> IO ()
commandHelp [] = Print.warningMessage "No arguments provided"
commandHelp (command : args) = do
  let fullCommand = unwords (command : args)
  Help.getHelp command
  unless (null args) $ Help.getHelp fullCommand
