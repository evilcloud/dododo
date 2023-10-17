module New
  ( createNewMicro,
    createNewTomorrow,
  )
where

import qualified Task.Constructor as TC
import Task.String as TS

createNewMicro :: String -> IO ()
createNewMicro message = do
  newTask <- TC.newMicro message
  putStrLn "New task created:\n"
  displayString <- TS.toSimpleString newTask
  putStrLn displayString

createNewTomorrow :: String -> IO ()
createNewTomorrow message = do
  newTask <- TC.newTomorrow message
  putStrLn "New task created:\n"
  displayString <- TS.toSimpleString newTask
  putStrLn displayString