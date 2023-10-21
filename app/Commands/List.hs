module Commands.List
  ( commandList,
    commandToday,
  )
where

import qualified Collection.Stdout as Stdout

commandList :: [String] -> IO ()
commandList _ = Stdout.listAllMicro

commandToday :: [String] -> IO ()
commandToday _ = Stdout.listAllTomorrow