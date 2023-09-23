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
doneCommand (arg1 : args) = do
  tasks <- TasksIO.getAllTasksFromCurrent
  let taskIds = map Task.taskId tasks
  if arg1 `elem` taskIds
    then case args of
      (arg2 : _) -> Status.changeStatus arg1 arg2
      [] -> Status.changeStatus arg1 "done"
    else closeLatestOpenTask arg1

closeLatestOpenTask :: String -> IO ()
closeLatestOpenTask newStatus = do
  tasks <- TasksIO.getAllTasksFromCurrent
  let taskMaybe = Filter.findLatestOpenTask tasks
  case taskMaybe of
    Just task -> Status.changeStatus (Task.taskId task) newStatus
    Nothing -> putStrLn $ "No open tasks found"
