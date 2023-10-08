-- Undone.hs
module Commands.Undone
  ( commandUndone,
  )
where

import qualified Task.Undone as Undone
import qualified Handlers.Status as Status

-- import qualified TasksIO

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
