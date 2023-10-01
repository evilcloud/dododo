{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Config.Default (defaultConfig, Config (..)) where

import Data.Aeson (FromJSON, ToJSON)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import GHC.Generics (Generic)

data Config = Config
  { taskInternalSeparator :: String,
    lifetime :: String,
    current :: String,
    past :: String,
    commandOptions :: Map String [String],
    sync :: String
  }
  deriving (Show, Generic)

instance ToJSON Config

instance FromJSON Config

defaultConfig :: Config
defaultConfig =
  Config
    { taskInternalSeparator = "  |  ",
      lifetime = "7",
      current = "~/.local/share/dododo/current.txt",
      past = "~/.local/share/dododo/past.txt",
      sync = "",
      commandOptions =
        Map.fromList
          [ ("new", ["new", "create", "add"]),
            ("task", ["task", "find", "search"]),
            ("status", ["status", "update", "change"]),
            ("done", ["done", "completed", "complete", "close", "closed", "finish", "finished"]),
            ("open", ["open", "reopen"]),
            ("delete", ["delete", "remove"]),
            ("undone", ["undone", "unlast", "reopen", "undo"]),
            ("help", ["help", "h", "?"]),
            ("editor", ["editor"]),
            ("edit", ["edit"]),
            ("config", ["config", "editconfig"])
          ]
    }
