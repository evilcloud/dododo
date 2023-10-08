module Commands.TestTask where

import qualified Task.Create as Create
import qualified Task.Update as Update

test :: IO ()
test = do
  task <- Create.createMicroTask "This is a task"
  print task

  updatedTask <- Update.updateMicroTask task "completed"
  print updatedTask
