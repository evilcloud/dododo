module Commands.TestTask where

import qualified Task.Task as Task

test :: IO ()
test = do
  task <- Task.createMicroTask "This is a task"
  print task

  updatedTask <- Task.updateMicroTask task "completed"
  print updatedTask
