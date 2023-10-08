module Config.Lifetime
  ( setLifetime,
  )
where

import Config.IO (updateConfig)

setLifetime :: String -> IO ()
setLifetime newLifetime = do
  _ <- updateConfig "SETTINGS" "lifetime" newLifetime
  return ()
