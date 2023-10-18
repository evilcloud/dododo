module Commands.Unknown (unknown) where

import qualified Printer.Print as Print

unknown :: IO ()
unknown = do
  Print.warningMessage "Unknown command"
