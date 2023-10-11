-- Config/IO.hs
module Config.IO where

import Config.Default (defaultConfig)
import Config.Types (Config, configFilePath)
import Data.ConfigFile
import FileManager as FileManager

getConfig :: IO Config
getConfig = do
  exists <- FileManager.fileExists configFilePath
  if exists
    then do
      content <- FileManager.readFromFile configFilePath
      case readstring emptyCP content of
        Right config -> return config
        Left _ -> writeDefaultConfig >> return defaultConfig
    else writeDefaultConfig >> return defaultConfig

writeConfig :: Config -> IO ()
writeConfig config = do
  let content = to_string config
  FileManager.overwriteFile configFilePath content

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
writeDefaultConfig = writeConfig defaultConfig
