module Commands.Unknown (unknown) where

import qualified Help.AllCommands as HAC
import qualified Printer.Print as Print

unknown :: [String] -> IO ()
unknown args = do
  Print.warningMessage $ "Unknown command: " ++ (unwords args)
  HAC.printAvailableCommands
