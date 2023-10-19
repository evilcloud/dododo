module Config.Editor where

import qualified Config.Config as CC
import qualified Config.IO as CIO
import qualified Printer.Print as Print

-- setEditor: the function that takes String with the editor name and sets it as "SETTINGS" "editor"
setEditor :: String -> IO ()
setEditor editor = do
  _ <- CIO.updateConfig "SETTINGS" "editor" editor
  printEditor
  return ()

printEditor :: IO ()
printEditor = do
  editor <- CC.editor
  Print.normalComment $ "Editor: " ++ editor
