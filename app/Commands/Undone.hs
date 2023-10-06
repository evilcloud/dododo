-- Undone.hs
module Commands.Undone
  ( commandUndone,
  )
where

import qualified Filter
import qualified Status
import Task.Task as Task (Task (..))
import qualified Task.Undone as Undone
import qualified TasksIO

commandUndone :: [String] -> IO ()
commandUndone [] = Undone.openLatestClosedTask
commandUndone [arg] = Status.changeStatus arg "open"
commandUndone _ = putStrLn "Too many arguments"

-- openLatestClosedTask :: IO ()
-- openLatestClosedTask = do
--   tasks <- TasksIO.getAllTasksFromCurrent
--   let taskMaybe = Filter.findLatestTaskWithStatus tasks
--   case taskMaybe of
--     Just task -> Status.changeStatus (Task.taskId task) "open"
--     Nothing -> putStrLn $ "No closed tasks found"
