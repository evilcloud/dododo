{-# LANGUAGE OverloadedStrings #-}

module Config.Config
  ( commandOptions,
    lifetime,
    taskInternalSeparator,
    past,
    current,
    sync,
    enterSync,
    loadOrRestoreConfigIO,
    resetToDefault,
  )
where

import Config.ConfigIO (loadConfig, saveConfig)
import Config.Default (Config (..), defaultConfig)
import Control.Monad (void, when)
import Data.Aeson (decodeFileStrict, encodeFile)
import FileManager (fileExists)
import System.Directory (doesFileExist)

-- Path to the configuration file
configPath :: FilePath
configPath = "~/.config/dododo/config.json"

loadOrRestoreConfigIO :: IO ()
loadOrRestoreConfigIO = do
  configExists <- fileExists configPath
  if configExists
    then do
      eConfig <- loadConfig configPath
      case eConfig of
        Left err -> putStrLn ("Error loading config: " ++ err) >> restoreDefault
        Right config -> putStrLn ("Config loaded: " ++ show config)
    else do
      putStrLn "Configuration file not found. Creating the default configuration..."
      restoreDefault
  where
    restoreDefault = saveConfig configPath defaultConfig >> putStrLn "Default configuration restored."

-- Update the sync field and save the new configuration
enterSync :: String -> IO ()
enterSync newSync = do
  eConfig <- loadConfig configPath
  case eConfig of
    Left err -> putStrLn ("Error loading config: " ++ err)
    Right config -> do
      let newConfig = config {sync = newSync}
      saveConfig configPath newConfig
      putStrLn ("Sync updated: " ++ show newConfig)

-- Reset configuration to default
resetToDefault :: IO ()
resetToDefault = do
  saveConfig configPath defaultConfig
  putStrLn "Configuration reset to default."
