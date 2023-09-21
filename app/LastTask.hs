module LastTask
  ( statusLastOpen,
    openLastStatus,
  )
where

import qualified Commands.Status as Status
import qualified Filter
import Task (Task (..))
import qualified TasksIO

-- Function to change the status of the latest open task
statusLastOpen :: String -> IO ()
statusLastOpen newStatus = do
  tasks <- TasksIO.getAllTasksFromCurrent
  let taskMaybe = Filter.findLatestOpenTask tasks
  case taskMaybe of
    Just task -> Status.changeStatus (taskId task) newStatus
    Nothing -> putStrLn $ "No open tasks found"

-- Function to change the status of the latest task that is not open to "open"
openLastStatus :: IO ()
openLastStatus = do
  tasks <- TasksIO.getAllTasksFromCurrent
  let taskMaybe = Filter.findLatestTaskWithStatus tasks
  case taskMaybe of
    Just task -> Status.changeStatus (taskId task) "open"
    Nothing -> putStrLn $ "No tasks with status found"