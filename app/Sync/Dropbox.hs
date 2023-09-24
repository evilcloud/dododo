module Sync.Dropbox where

import Control.Monad (filterM, void)
import Data.Maybe (catMaybes)
import System.Directory (doesDirectoryExist, getHomeDirectory)
import System.FilePath ((</>))

dropboxDirs :: [FilePath]
dropboxDirs = ["Dropbox", "Dropbox (Personal)", "Dropbox (Business)"]

checkAndPrintDir :: FilePath -> IO (Maybe FilePath)
checkAndPrintDir dir = do
  homeDir <- getHomeDirectory
  let fullPath = homeDir </> dir
  exists <- doesDirectoryExist fullPath
  if exists
    then do
      putStrLn $ "Directory exists: " ++ fullPath
      return (Just fullPath)
    else return Nothing

getDropboxDirs :: [FilePath] -> IO [FilePath]
getDropboxDirs dirs = do
  maybeDirs <- mapM checkAndPrintDir dirs
  return (catMaybes maybeDirs)

handleDropboxDirs :: [FilePath] -> IO ()
handleDropboxDirs dirs = case dirs of
  [] -> putStrLn "No Dropbox directories found"
  [dir] -> putStrLn $ "Single Dropbox directory found: " ++ dir
  _ -> do
    putStrLn "Multiple Dropbox directories found. Please indicate which do you want to use"
    mapM_ putStrLn dirs

findDropboxDirs :: [FilePath] -> IO ()
findDropboxDirs dirs = case dirs of
  [] -> do
    existingDirs <- getDropboxDirs dropboxDirs
    void $ handleDropboxDirs existingDirs
  (dir : _) -> putStrLn $ "You've submitted " ++ dir
