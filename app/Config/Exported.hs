module Config.Exported
  ( configFilePath,
    current,
    past,
    lifetime,
    taskInternalSeparator,
  )
where

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

taskInternalSeparator :: String
taskInternalSeparator = "  |  "