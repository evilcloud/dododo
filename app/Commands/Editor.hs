module Commands.Editor (commandEditor) where

import qualified Config.Editor as CE
import qualified Edit.Editor as EE

commandEditor :: [String] -> IO ()
commandEditor [] = EE.printCurrentEditor
commandEditor (editor : _) = CE.setEditor editor
