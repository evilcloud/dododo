module Config.Lifetime
  ( setLifetime,
    printLifetime,
  )
where

import Config.Config as CC
import Config.IO as CIO
import qualified Printer.Print as Print

setLifetime :: String -> IO ()
setLifetime newLifetime = do
  _ <- CIO.updateConfig "SETTINGS" "lifetime" newLifetime
  printLifetime
  return ()

printLifetime :: IO ()
printLifetime = do
  lifetime <- CC.lifetime
  Print.normalComment $ "Lifetime: " ++ lifetime ++ " days"
