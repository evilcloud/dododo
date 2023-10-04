module Task.TaskId (generateId) where

import System.Random (randomRIO)

characters :: String
characters = ['a' .. 'z']

generateId :: IO String
generateId = sequence $ replicate 6 $ pickRandom characters

pickRandom :: String -> IO Char
pickRandom xs = (!!) xs <$> randomRIO (0, length xs - 1)
