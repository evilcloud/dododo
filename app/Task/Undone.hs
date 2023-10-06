module Task.Undone
  ( openLatestClosedTask,
  )
where

import qualified Filter
import qualified Status
import Task.Task as Task (Task (..))
import qualified TasksIO

openLatestClosedTask :: IO ()
openLatestClosedTask = do
  tasks <- TasksIO.getAllTasksFromCurrent
  let taskMaybe = Filter.findLatestTaskWithStatus tasks
  case taskMaybe of
    Just task -> Status.changeStatus (Task.taskId task) "open"
    Nothing -> putStrLn $ "No closed tasks found"
