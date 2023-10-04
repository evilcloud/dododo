module New.New where

import qualified Task.Format as Format
import qualified Task.Task as Task

createNewTask :: [String] -> IO ()
createNewTask words = do
  let message = unwords words
  task <- Task.createMicroTask message
  printTask task

printTask :: Task.Task -> IO ()
printTask task = do
  taskStr <- Format.taskForPrint task
  putStrLn taskStr
