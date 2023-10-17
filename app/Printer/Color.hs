module Printer.Color
  ( blue,
    yellow,
    red,
    green,
  )
where

blue :: [String] -> IO ()
blue lines = do
  putStrLn "\ESC[1;34m"
  putStr $ unlines lines
  putStrLn "\ESC[m"

yellow :: [String] -> IO ()
yellow lines = do
  putStrLn "\ESC[1;33m"
  putStr $ unlines lines
  putStrLn "\ESC[m"

red :: [String] -> IO ()
red lines = do
  putStrLn "\ESC[1;31m"
  putStr $ unlines lines
  putStrLn "\ESC[m"

green :: [String] -> IO ()
green lines = do
  putStrLn "\ESC[1;32m"
  putStr $ unlines lines
  putStrLn "\ESC[m"
