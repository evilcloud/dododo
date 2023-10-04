{-# LANGUAGE OverloadedStrings #-}

module Config.Default
  ( DefaultConfig (..),
    writeDefaultConfig,
    configFilePath,
  )
where

import Data.Default (Default, def)
import FileManager as FM

configFilePath :: FilePath
configFilePath = "~/.config/dododo/config.ini"

data DefaultConfig = DefaultConfig
  { defaultCurrent :: FilePath,
    defaultPast :: FilePath,
    defaultSync :: FilePath,
    defaultLifetime :: String,
    defaultTaskInternalSeparator :: String
  }

instance Default DefaultConfig where
  def =
    DefaultConfig
      { defaultCurrent = "~/.local/share/dododo/current.txt",
        defaultPast = "~/.local/share/dododo/past.txt",
        defaultSync = "",
        defaultLifetime = "7",
        defaultTaskInternalSeparator = "  |  "
      }

writeDefaultConfig :: IO ()
writeDefaultConfig = do
  let defaultConfig = def
      configContent =
        unlines
          [ "[PATHS]",
            "current = " ++ defaultCurrent defaultConfig,
            "past = " ++ defaultPast defaultConfig,
            "sync = " ++ defaultSync defaultConfig,
            "",
            "[TASKS]",
            "lifetime = " ++ defaultLifetime defaultConfig,
            "taskInternalSeparator = " ++ defaultTaskInternalSeparator defaultConfig
          ]
  FM.overwriteFile configFilePath configContent
