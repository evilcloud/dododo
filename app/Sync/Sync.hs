module Sync.Sync
  ( syncDirs,
    configFilePath,
    syncStatus,
    getSyncDirs,
    writeToConfig,
    disableSync,
    findSyncDirs,
    handleSyncDirs,
    checkAndPrintSyncDir,
  )
where

-- import qualified Config.Config as Config
import qualified Config.IO as ConfigIO
import Control.Monad (filterM, void)
import Data.ConfigFile
import Data.Either.Utils (forceEither)
import Data.Maybe (catMaybes)
import FileManager (directoryExists, renormalizePath)

syncDirs :: [FilePath]
syncDirs = ["~/Dropbox", "~/Dropbox (Personal)", "~/Dropbox (Business)"]

configFilePath :: FilePath
configFilePath = "~/.config/dododo/config"

checkAndPrintSyncDir :: FilePath -> IO (Maybe FilePath)
checkAndPrintSyncDir dir = do
  exists <- directoryExists dir
  if exists
    then do
      return (Just dir)
    else return Nothing

getSyncDirs :: [FilePath] -> IO [FilePath]
getSyncDirs dirs = do
  maybeDirs <- mapM checkAndPrintSyncDir dirs
  return (catMaybes maybeDirs)

handleSyncDirs :: [FilePath] -> IO ()
handleSyncDirs dirs = case dirs of
  [] -> putStrLn "No sync directories found"
  [dir] -> do
    putStrLn $ "Single sync directory found:\n" ++ dir
    writeToConfig dir
  _ -> do
    putStrLn "Multiple sync directories found. Please indicate which one you want to use:"
    mapM_ putStrLn dirs

writeToConfig :: FilePath -> IO ()
writeToConfig newPath = do
  putStrLn "Writing to config"
  newPath <- renormalizePath newPath
  updateSyncPath newPath

disableSync :: IO ()
disableSync = do
  updateSyncPath ""
  putStrLn "Disabling sync"

findSyncDirs :: [FilePath] -> IO ()
findSyncDirs dirs = do
  existingDirs <- filterM directoryExists dirs
  handleSyncDirs existingDirs

syncStatus :: IO ()
syncStatus = do
  config <- ConfigIO.getConfig
  let syncValueEither = get config "PATHS" "sync"
  case syncValueEither of
    Left _ -> putStrLn "off"
    Right syncValue ->
      if null syncValue
        then putStrLn "off"
        else putStrLn syncValue

updateSyncPath :: FilePath -> IO ()
updateSyncPath newPath = do
  newConfig <- ConfigIO.updateConfig "PATHS" "sync" newPath
  return ()
