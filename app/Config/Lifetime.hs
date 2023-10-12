module Config.Lifetime
  ( setLifetime,
    printLifetime,
  )
where

import Config.Config as CC
import Config.IO as CIO

setLifetime :: String -> IO ()
setLifetime newLifetime = do
  _ <- CIO.updateConfig "SETTINGS" "lifetime" newLifetime
  return ()

printLifetime :: IO ()
printLifetime = do
  let lifetime = CC.lifetime
  putStrLn $ "Lifetime: " ++ lifetime ++ " days"