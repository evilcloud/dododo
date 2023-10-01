{-# LANGUAGE OverloadedStrings #-}

module Config.Model
  ( Config (..),
  )
where

-- Define a new data type to hold the configuration
data Config = Config
  { current :: FilePath,
    past :: FilePath,
    sync :: FilePath,
    lifetime :: String,
    taskInternalSeparator :: String
  }
  deriving (Show)
