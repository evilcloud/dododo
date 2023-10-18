module Commands.Reset (resetConfig) where

import Config.IO as CIO
import qualified Help.Commands as Help
import qualified Printer.Print as Print

resetConfig :: [String] -> IO ()
resetConfig [] = do
  Print.warningMessage "config.ini is reset to default"
  CIO.writeDefaultConfig
resetConfig _ = do
  Help.getHelp "reset"
