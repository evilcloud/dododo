{-# LANGUAGE OverloadedStrings #-}

module Config.Load
  ( loadConfig,
    Config (..),
  )
where

import Config.Default (configFilePath, writeDefaultConfig)
import Config.Model (Config (..))
import Data.Ini
import Data.Text (pack, unpack)
import FileManager (readFromFile)
import System.IO.Unsafe (unsafePerformIO)

-- Define a function to read the config file
readConfig :: IO String
readConfig = readFromFile configFilePath

-- Define a function to handle parsing errors
handleError :: String -> IO Ini
handleError err = do
  putStrLn $ "Error loading config: " ++ err ++ ". Resetting to default config."
  writeDefaultConfig
  content <- readConfig
  let parsed = parseIni (pack content)
  case parsed of
    Left err' -> handleError err'
    Right ini -> return ini

-- Define a function to load the config
loadConfig :: Config
loadConfig = unsafePerformIO $ do
  content <- readConfig
  ini <- either handleError return $ parseIni (pack content)
  let current = lookupValue "PATHS" "current" ini
      past = lookupValue "PATHS" "past" ini
      sync = lookupValue "PATHS" "sync" ini
      lifetime = lookupValue "TASKS" "lifetime" ini
      taskInternalSeparator = lookupValue "TASKS" "taskInternalSeparator" ini
  case (current, past, sync, lifetime, taskInternalSeparator) of
    (Right current', Right past', Right sync', Right lifetime', Right taskInternalSeparator') ->
      return
        Config
          { current = unpack current',
            past = unpack past',
            sync = unpack sync',
            lifetime = unpack lifetime',
            taskInternalSeparator = unpack taskInternalSeparator'
          }
    _ -> error "Failed to parse some configuration values. Resetting to default config."
