{-# LANGUAGE OverloadedStrings #-}

module Config.ConfigIO (loadConfig, saveConfig) where

import Config.Default (Config)
import Control.Exception (IOException, try)
import Data.Aeson (eitherDecode)
import Data.Aeson.Encode.Pretty (encodePretty)
import qualified Data.ByteString.Lazy.Char8 as B
import FileManager (normalizePath, overwriteFile, readFromFile)
import System.Directory (doesFileExist, getHomeDirectory)
import System.FilePath.Posix (joinPath, splitDirectories)

-- Load configuration from a file
loadConfig :: FilePath -> IO (Either String Config)
loadConfig path = do
  normalizedPath <- normalizePath path
  content <- readFromFile normalizedPath
  return $ eitherDecode $ B.pack content

-- Save configuration to a file
saveConfig :: FilePath -> Config -> IO ()
saveConfig path config = do
  normalizedPath <- normalizePath path
  overwriteFile normalizedPath $ B.unpack $ encodePretty config
