{-# LANGUAGE OverloadedStrings #-}

module Config.Config
  ( Config,
    getConfig,
    updateConfig,
    configFilePath,
    current,
    past,
    commandOptions,
    lifetime,
    taskInternalSeparator,
  )
where

import Config.Default (defaultConfig)
import Data.ConfigFile
import Data.Either
import Data.Either.Utils (forceEither)
import Data.List.Split (splitOn)
import qualified Data.Map as M
import FileManager (fileExists, overwriteFile, readFromFile)
import System.IO.Unsafe (unsafePerformIO)

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

-- Define the exported values
current :: String
current = unsafePerformIO $ do
  config <- getConfig
  return $ forceEither $ get config "PATHS" "current"

past :: String
past = unsafePerformIO $ do
  config <- getConfig
  return $ forceEither $ get config "PATHS" "past"

commandOptions :: M.Map String [String]
commandOptions = unsafePerformIO $ do
  config <- getConfig
  let options = forceEither $ items config "OPTIONS"
  let parsedOptions = map (\(option, value) -> (option, splitOn "," value)) options
  return $ M.fromList parsedOptions

lifetime :: String
lifetime = unsafePerformIO $ do
  config <- getConfig
  return $ forceEither $ get config "SETTINGS" "lifetime"

taskInternalSeparator :: String
taskInternalSeparator = "  |  "
