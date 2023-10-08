{-# LANGUAGE OverloadedStrings #-}

module Config.Config
  ( Config,
    configFilePath,
    current,
    past,
    lifetime,
  )
where

import Config.Default (defaultConfig)
import Config.IO (getConfig, updateConfig, writeConfig)
import Config.Types (Config, configFilePath)
import Data.ConfigFile
import Data.Either
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

lifetime :: String
lifetime = unsafePerformIO $ do
  config <- getConfig
  return $ forceEither $ get config "SETTINGS" "lifetime"
