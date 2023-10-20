module Edit.Edit
  ( editCurrent,
    editConfig,
  )
where

import qualified Config.Config as CC
import qualified Config.Exported as ConfExp
import qualified Edit.Editor as EE

editCurrent :: IO ()
editCurrent = do
  let currentFilePath = CC.current
  EE.editFile currentFilePath

editConfig :: IO ()
editConfig = do
  let configFilePath = ConfExp.configFilePath
  EE.editFile configFilePath