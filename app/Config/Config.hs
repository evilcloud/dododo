{-# LANGUAGE OverloadedStrings #-}

module Config.Config
  ( Config,
    configFilePath,
    current,
    past,
    lifetime,
    editor,
    updateConfig,
  )
where

import Config.IO (getConfig, updateConfig, writeConfig)
import Config.Types (Config, configFilePath)
import Data.ConfigFile
import Data.Either.Utils (forceEither)
import System.IO.Unsafe (unsafePerformIO)

-- Define the exported values
current :: String
current = unsafePerformIO $ do
  config <- getConfig
  return $ forceEither $ get config "PATHS" "current"

past :: String
past = unsafePerformIO $ do
  config <- getConfig
  return $ forceEither $ get config "PATHS" "past"

lifetime :: IO String
lifetime = do
  config <- getConfig
  return $ forceEither $ get config "SETTINGS" "lifetime"

-- Define the exported values
editor :: IO String
editor = do
  config <- getConfig
  return $ forceEither $ get config "SETTINGS" "editor"
