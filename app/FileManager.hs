module FileManager.FileManager
  ( readFromFile,
    appendToFile,
    writeToFile,
    fileExists,
    directoryExists,
    pathTildeToHome,
    pathHomeToTilde,
  )
where

import Data.List (isPrefixOf)
import System.Directory (doesDirectoryExist, doesFileExist, getHomeDirectory)
import System.FilePath ((</>))
import System.IO

-- Read from file
readFromFile :: FilePath -> IO String
readFromFile path = do
  normalizedPath <- pathTildeToHome path
  System.IO.readFile normalizedPath

-- Append to file
appendToFile :: FilePath -> String -> IO ()
appendToFile path content = do
  normalizedPath <- pathTildeToHome path
  System.IO.appendFile normalizedPath content

-- Overwrite file
writeToFile :: FilePath -> String -> IO ()
writeToFile path content = do
  normalizedPath <- pathTildeToHome path
  System.IO.writeFile normalizedPath content

-- Normalize path
pathTildeToHome :: FilePath -> IO FilePath
pathTildeToHome path = do
  homeDirectory <- getHomeDirectory
  return $
    if "~/" `isPrefixOf` path
      then homeDirectory </> drop 2 path
      else path

pathHomeToTilde :: FilePath -> IO FilePath
pathHomeToTilde path = do
  homeDirectory <- getHomeDirectory
  if homeDirectory `isPrefixOf` path
    then return $ "~/" ++ drop (length homeDirectory + 1) path
    else return path

fileExists :: FilePath -> IO Bool
fileExists path = do
  normalizedPath <- pathTildeToHome path
  doesFileExist normalizedPath

directoryExists :: FilePath -> IO Bool
directoryExists path = do
  normalizedPath <- pathTildeToHome path
  doesDirectoryExist normalizedPath