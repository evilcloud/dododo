module Config.Default
  ( defaultConfig,
  )
where

import Data.ConfigFile
import Data.Either.Utils (forceEither)

-- defaultConfig :: ConfigParser
-- defaultConfig =
--   let configContent =
--         "[PATHS]\n\
--         \current = ~/.local/share/dododo/current.txt\n\
--         \past = ~/.local/share/dododo/past.txt\n\
--         \sync = \n\
--         \\n\
--         \[TEMPORAL]\n\
--         \lifetime = 7"
--    in forceEither $ readstring emptyCP configContent

defaultConfig :: ConfigParser
defaultConfig =
  let configContent =
        "[PATHS]\n\
        \current = ~/.local/share/dododo/current.txt\n\
        \past = ~/.local/share/dododo/past.txt\n\
        \sync = \n\
        \\n\
        \[SETTINGS]\n\
        \lifetime = 7\n\
        \sync = False\n\
        \editor = "
   in forceEither $ readstring emptyCP configContent
