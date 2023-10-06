module Task.Generator (taskID) where

import System.Random (randomRIO)

characters :: String
characters = ['a' .. 'z']

taskID :: IO String
taskID = sequence $ replicate 6 $ pickRandom characters

pickRandom :: String -> IO Char
pickRandom xs = (!!) xs <$> randomRIO (0, length xs - 1)
