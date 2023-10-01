module Sync.Sync where

import Control.Monad (filterM, void)
import Data.Maybe (catMaybes)
import FileManager
import System.Directory (doesDirectoryExist, getHomeDirectory)
import System.FilePath ((</>))

syncDirs :: [FilePath]
syncDirs = ["Dropbox", "Dropbox (Personal)", "Dropbox (Business)"]

configFilePath :: FilePath
configFilePath = "~/.config/dododo/config"

checkAndPrintSyncDir :: FilePath -> IO (Maybe FilePath)
checkAndPrintSyncDir dir = do
  homeDir <- getHomeDirectory
  let fullPath = homeDir </> dir
  exists <- doesDirectoryExist fullPath
  if exists
    then do
      putStrLn $ "Directory exists: " ++ fullPath
      return (Just fullPath)
    else return Nothing

getSyncDirs :: [FilePath] -> IO [FilePath]
getSyncDirs dirs = do
  maybeDirs <- mapM checkAndPrintSyncDir dirs
  return (catMaybes maybeDirs)

handleSyncDirs :: [FilePath] -> IO ()
handleSyncDirs dirs = case dirs of
  [] -> putStrLn "No sync directories found"
  [dir] -> do
    putStrLn $ "Single sync directory found: " ++ dir
    writeToConfig dir
  _ -> do
    putStrLn "Multiple sync directories found. Please indicate which one you want to use:"
    mapM_ putStrLn dirs

writeToConfig :: FilePath -> IO ()
writeToConfig dir = do
  putStrLn "Writing to config"

disableSync :: IO ()
disableSync = do
  putStrLn "Disabling sync"

findSyncDirs :: [FilePath] -> IO ()
findSyncDirs dirs = case dirs of
  [] -> do
    existingDirs <- getSyncDirs syncDirs
    void $ handleSyncDirs existingDirs
  ["off"] -> disableSync
  (dir : _) -> do
    exists <- doesDirectoryExist dir
    if exists
      then writeToConfig dir
      else putStrLn $ "Directory does not exist: " ++ dir
