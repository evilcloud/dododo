module Config.Exported
  ( configFilePath,
    current,
    past,
    lifetime,
    taskInternalSeparator,
    editor,
    editors,
  )
where

import Config.IO (get, getConfig)
import Data.Either.Utils (forceEither)
import Data.List.Split (splitOn)
import System.IO.Unsafe (unsafePerformIO)

-- type Config = ConfigParser

configFilePath :: FilePath
configFilePath = "~/.config/dododo/config.ini"

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

editor :: String
editor = unsafePerformIO $ do
  config <- getConfig
  return $ forceEither $ get config "SETTINGS" "editor"

editors :: [String]
editors = unsafePerformIO $ do
  config <- getConfig
  return $ splitOn "," $ forceEither $ get config "OPTIONS" "editors"

taskInternalSeparator :: String
taskInternalSeparator = "  |  "