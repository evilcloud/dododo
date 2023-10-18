{-# LANGUAGE FlexibleInstances #-}

module Printer.Color
  ( blue,
    yellow,
    red,
    green,
    darkGray,
    magenta,
    cyan,
  )
where

class Printable a where
  toLines :: a -> [String]

instance Printable String where
  toLines s = [s]

instance Printable [String] where
  toLines = id

colorPrint :: (Printable a) => String -> a -> IO ()
colorPrint colorCode lines = do
  putStrLn colorCode
  putStr $ unlines $ toLines lines
  putStrLn "\ESC[m"

blue :: (Printable a) => a -> IO ()
blue = colorPrint "\ESC[1;34m"

yellow :: (Printable a) => a -> IO ()
yellow = colorPrint "\ESC[1;33m"

red :: (Printable a) => a -> IO ()
red = colorPrint "\ESC[1;31m"

green :: (Printable a) => a -> IO ()
green = colorPrint "\ESC[1;32m"

cyan :: (Printable a) => a -> IO ()
cyan = colorPrint "\ESC[1;36m"

magenta :: (Printable a) => a -> IO ()
magenta = colorPrint "\ESC[1;35m"

darkGray :: (Printable a) => a -> IO ()
darkGray = colorPrint "\ESC[1;90m"
