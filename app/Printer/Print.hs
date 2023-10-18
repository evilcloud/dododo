{-# LANGUAGE FlexibleInstances #-}

module Printer.Print
  ( normalComment,
    warningMessage,
    helpMessage,
    standardOutput,
  )
where

import Printer.Color

class Commentable a where
  toComment :: a -> String

instance Commentable String where
  toComment s = s

instance Commentable [String] where
  toComment = unlines

normalComment :: (Commentable a) => a -> IO ()
normalComment comment = do
  putStrLn ""
  Printer.Color.blue $ toComment comment
  putStrLn ""

warningMessage :: (Commentable a) => a -> IO ()
warningMessage comment = do
  putStrLn ""
  Printer.Color.yellow $ toComment comment
  putStrLn ""

helpMessage :: (Commentable a) => a -> IO ()
helpMessage comment = do
  putStrLn ""
  Printer.Color.darkGray $ toComment comment
  putStrLn ""

standardOutput :: (Commentable a) => a -> IO ()
standardOutput comment = do
  putStrLn ""
  putStrLn $ toComment comment
  putStrLn ""
