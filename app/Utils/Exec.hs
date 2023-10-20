module Utils.Exec (executeFile) where

import System.Process (callProcess)

executeFile :: FilePath -> [String] -> IO ()
executeFile = callProcess
