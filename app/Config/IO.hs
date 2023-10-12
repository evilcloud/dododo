-- Config/IO.hs
module Config.IO where

import Config.Default as CD
import Config.Types (Config, configFilePath)
import Data.ConfigFile
import FileManager

getConfig :: IO Config
getConfig = do
  exists <- FileManager.fileExists configFilePath
  if exists
    then do
      fileContent <- FileManager.readFromFile configFilePath
      case readstring emptyCP fileContent of
        Right config -> return config
        Left _ -> writeDefaultConfig >> return CD.defaultConfig
    else writeDefaultConfig >> return CD.defaultConfig

writeConfig :: Config -> IO ()
writeConfig config = do
  let fileContent = to_string config
  FileManager.overwriteFile configFilePath fileContent

updateConfig :: SectionSpec -> OptionSpec -> String -> IO Config
updateConfig section option newValue = do
  config <- getConfig
  let updatedConfig = set config section option newValue
  case updatedConfig of
    Left _ -> return config
    Right newConfig -> do
      writeConfig newConfig
      return newConfig

writeDefaultConfig :: IO ()
writeDefaultConfig = writeConfig CD.defaultConfig
