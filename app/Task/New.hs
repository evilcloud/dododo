module Task.New
  ( createNewMicro,
    createNewTomorrow,
  )
where

import qualified Collection.Stdout as Stdout
import qualified Printer.Print as Print
import qualified Task.Constructor as TC
-- import Task.IO as TIO
import Task.Model (Task (..))
import Task.String as TS

createNewMicro :: String -> IO ()
createNewMicro message = do
  newTask <- TC.newMicro message
  Print.normalComment "New micro task created:"
  displayString <- TS.toSimpleString newTask
  -- saveString <- TS.toSaveString newTask
  Print.standardOutput displayString
  Stdout.appendMicro (MicroTask newTask)

-- TIO.addMicroToFile saveString

createNewTomorrow :: String -> IO ()
createNewTomorrow message = do
  newTask <- TC.newTomorrow message
  Print.normalComment "New tomorrow task created:"
  displayString <- TS.toSimpleString newTask
  Print.standardOutput displayString
