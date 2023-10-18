-- Config/Types.hs
module Config.Types
  ( Config,
    configFilePath,
    taskInternalSeparator,
  )
where

import Data.ConfigFile

type Config = ConfigParser

configFilePath = "~/.config/dododo/config.ini"

taskInternalSeparator :: String
taskInternalSeparator = "  |  "