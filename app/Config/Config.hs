module Config.Config
  ( Config,
    getConfig,
    updateConfig,
    configFilePath,
  )
where

import Config.Default (defaultConfig)
import Data.ConfigFile
import Data.Either
import Data.Either.Utils (forceEither)
import FileManager (fileExists, overwriteFile, readFromFile)

type Config = ConfigParser

configFilePath = "~/.config/dododo/config.ini"

getConfig :: IO Config
getConfig = do
  exists <- fileExists configFilePath
  if exists
    then do
      content <- readFromFile configFilePath
      case readstring emptyCP content of
        Right config -> return config
        Left _ -> handleDefaultConfig
    else handleDefaultConfig
  where
    handleDefaultConfig = do
      writeConfig defaultConfig
      return defaultConfig

writeConfig :: Config -> IO ()
writeConfig config = do
  let content = to_string config
  overwriteFile configFilePath content

updateConfig :: SectionSpec -> OptionSpec -> String -> IO Config
updateConfig section option newValue = do
  config <- getConfig
  let updatedConfig = set config section option newValue
  case updatedConfig of
    Left _ -> return config
    Right newConfig -> do
      writeConfig newConfig
      return newConfig
