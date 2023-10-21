module Collection.Print
  ( printTasks,
  )
where

import Control.Monad (forM_)
import qualified Printer.Print as Print
import Task.Model (Task)
import Task.String (toDisplayString)

printTasks :: String -> [Task] -> IO ()
printTasks taskType tasks = do
  putStrLn taskType
  forM_ tasks $ \task -> do
    taskStr <- Task.String.toDisplayString task
    Print.printTask taskStr
