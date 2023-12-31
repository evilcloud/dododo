module FileManager
  ( readFromFile,
    appendToFile,
    overwriteFile,
    updateFile,
    fileExists,
    normalizePath,
    directoryExists,
    renormalizePath,
  )
where

import Data.List (isPrefixOf)
import System.Directory (doesDirectoryExist, doesFileExist, getHomeDirectory)
import System.FilePath ((</>))
import System.IO

-- Read from file
readFromFile :: FilePath -> IO String
readFromFile path = do
  normalizedPath <- normalizePath path
  withFile
    normalizedPath
    ReadMode
    ( \h -> do
        contents <- hGetContents h
        length contents `seq` return contents
    )

-- Append to file
appendToFile :: FilePath -> String -> IO ()
appendToFile path content = do
  normalizedPath <- normalizePath path
  withFile normalizedPath AppendMode (\h -> hPutStr h content)

-- Update file
updateFile :: FilePath -> String -> IO ()
updateFile path content = do
  normalizedPath <- normalizePath path
  withFile normalizedPath WriteMode (\h -> hPutStr h content)

-- Overwrite file
overwriteFile :: FilePath -> String -> IO ()
overwriteFile path content = do
  normalizedPath <- normalizePath path
  withFile normalizedPath WriteMode (\h -> hPutStr h content)

-- Normalize path
normalizePath :: FilePath -> IO FilePath
normalizePath path = do
  homeDirectory <- getHomeDirectory
  return $
    if "~/" `isPrefixOf` path
      then homeDirectory </> drop 2 path
      else path

renormalizePath :: FilePath -> IO FilePath
renormalizePath path = do
  homeDirectory <- getHomeDirectory
  if homeDirectory `isPrefixOf` path
    then return $ "~/" ++ drop (length homeDirectory + 1) path
    else return path

-- Check if file exists
fileExists :: FilePath -> IO Bool
fileExists path = do
  normalizedPath <- normalizePath path
  doesFileExist normalizedPath

directoryExists :: FilePath -> IO Bool
directoryExists path = do
  normalizedPath <- normalizePath path
  doesDirectoryExist normalizedPath