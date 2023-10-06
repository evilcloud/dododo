module Task.Done (closeLatestOpenTask, changeStatus) where

import qualified Filter
import qualified Status
import Task.Task as Task (Task (..))
import qualified TasksIO

closeLatestOpenTask :: String -> IO ()
closeLatestOpenTask newStatus = do
  tasks <- TasksIO.getAllTasksFromCurrent
  let taskMaybe = Filter.findLatestOpenTask tasks
  case taskMaybe of
    Just task -> Status.changeStatus (Task.taskId task) newStatus
    Nothing -> putStrLn $ "No open tasks found"

changeStatus :: String -> String -> IO ()
changeStatus arg1 newStatus = do
  tasks <- TasksIO.getAllTasksFromCurrent
  let taskIds = map Task.taskId tasks
  if arg1 `elem` taskIds
    then Status.changeStatus arg1 newStatus
    else closeLatestOpenTask arg1
