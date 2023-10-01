module Sync.Sync where

import Control.Monad (filterM, void)
import Data.Maybe (catMaybes)
import FileManager (directoryExists, normalizePath)

syncDirs :: [FilePath]
syncDirs = ["Dropbox", "Dropbox (Personal)", "Dropbox (Business)"]

configFilePath :: FilePath
configFilePath = "~/.config/dododo/config"

checkAndPrintSyncDir :: FilePath -> IO (Maybe FilePath)
checkAndPrintSyncDir dir = do
  exists <- directoryExists dir
  if exists
    then do
      --   putStrLn $ "Directory exists: " ++ dir
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
writeToConfig dir = do
  putStrLn "Writing to config"

disableSync :: IO ()
disableSync = do
  putStrLn "Disabling sync"

findSyncDirs :: [FilePath] -> IO ()
findSyncDirs dirs = do
  existingDirs <- filterM directoryExists dirs
  handleSyncDirs existingDirs