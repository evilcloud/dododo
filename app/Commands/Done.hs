module Commands.Done
  ( doneCommand,
  )
where

import qualified Filter
import qualified Status
import Task (Task (..))
import qualified TasksIO

doneCommand :: [String] -> IO ()
doneCommand [] = closeLatestOpenTask "done"
doneCommand [arg] = Status.changeStatus arg "done"
doneCommand (arg1 : arg2 : _) = Status.changeStatus arg1 arg2

closeLatestOpenTask :: String -> IO ()
closeLatestOpenTask newStatus = do
  tasks <- TasksIO.getAllTasksFromCurrent
  let taskMaybe = Filter.findLatestOpenTask tasks
  case taskMaybe of
    Just task -> Status.changeStatus (taskId task) newStatus
    Nothing -> putStrLn $ "No open tasks found"
