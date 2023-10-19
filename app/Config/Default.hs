module Config.Default
  ( defaultConfig,
    currentPath,
    pastPath,
    lifetime,
    sync,
    editor,
    editors,
  )
where

import Data.ConfigFile
import Data.Either.Utils (forceEither)
import Data.List (intercalate)


currentPath :: String
currentPath = "~/.local/share/dododo/current.txt"

pastPath :: String
pastPath = "~/.local/share/dododo/past.txt"

lifetime :: Int
lifetime = 7

sync :: Bool
sync = False

editor :: String
editor = ""

editors :: [String]
editors = ["vim", "ed", "nvim", "neovide", "nano", "emacs", "code", "subl", "atom"]

defaultConfig :: ConfigParser
defaultConfig =
  let configContent =
        "[PATHS]\n\
        \current = " ++ currentPath ++ "\n\
        \past = " ++ pastPath ++ "\n\
        \\n\
        \[SETTINGS]\n\
        \lifetime = " ++ show lifetime ++ "\n\
        \sync = " ++ show sync ++ "\n\
        \editor = " ++ editor ++ "\n\
        \\n\
        \[OPTIONS]\n\
        \editors = " ++ intercalate "," editors
   in forceEither $ readstring emptyCP configContent
