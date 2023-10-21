module Collection.Stdout
  ( listAll,
    saveAll,
    listAllMicro,
    listAllTomorrow,
    appendMicro,
  )
where

import qualified Collection.Filter as CF
import qualified Collection.IO as CIO
import Control.Monad ((>=>))
import qualified Printer.Print as Print
import Task.Model (Task (..))
import qualified Task.String as String (toDisplayString, toSaveString)

listAll :: IO ()
listAll = do
  tasks <- CIO.loadTasks
  let completedTomorrowTasks = CF.completedTomorrow tasks
  let incompleteTomorrowTasks = CF.incompleteTomorrow tasks
  let completedMicroTasks = CF.completedMicro tasks
  let incompleteMicroTasks = CF.incompleteMicro tasks
  mapM_
    (String.toDisplayString >=> putStrLn)
    ( completedTomorrowTasks
        ++ incompleteTomorrowTasks
        ++ completedMicroTasks
        ++ incompleteMicroTasks
    )

saveAll :: [Task] -> IO ()
saveAll tasks = do
  let completedTomorrowTasks = CF.completedTomorrow tasks
  let incompleteTomorrowTasks = CF.incompleteTomorrow tasks
  let completedMicroTasks = CF.completedMicro tasks
  let incompleteMicroTasks = CF.incompleteMicro tasks
  let allTasks =
        completedTomorrowTasks
          ++ incompleteTomorrowTasks
          ++ completedMicroTasks
          ++ incompleteMicroTasks
  taskStrings <- mapM String.toSaveString allTasks
  CIO.saveTasks taskStrings

-- listAllMicro :: IO ()
-- listAllMicro = do
--   tasks <- CIO.loadTasks
--   let completedMicroTasks = CF.completedMicro tasks
--   let incompleteMicroTasks = CF.incompleteMicro tasks

--   mapM_
--     (String.toDisplayString >=> putStrLn)
--     (completedMicroTasks ++ incompleteMicroTasks)

listAllMicro :: IO ()
listAllMicro = do
  tasks <- CIO.loadTasks
  let completedMicroTasks = CF.completedMicro tasks
  let incompleteMicroTasks = CF.incompleteMicro tasks
  taskStrings <- mapM String.toDisplayString (completedMicroTasks ++ incompleteMicroTasks)
  Print.printTaskList taskStrings

listAllTomorrow :: IO ()
listAllTomorrow = do
  tasks <- CIO.loadTasks
  let completedTomorrowTasks = CF.completedTomorrow tasks
  let incompleteTomorrowTasks = CF.incompleteTomorrow tasks
  mapM_
    (String.toDisplayString >=> putStrLn)
    (completedTomorrowTasks ++ incompleteTomorrowTasks)

appendMicro :: Task -> IO ()
appendMicro task = do
  taskString <- String.toSaveString task
  CIO.appendMicro $ taskString ++ "\n"
