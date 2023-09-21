module Commands.New
  ( new,
  )
where

import qualified Task
import qualified TasksIO

-- Function for the 'new' command
new :: String -> IO ()
new message = do
  task <- Task.createTask message
  TasksIO.addTaskToCurrent task
  putStrLn $ Task.formatTask task
