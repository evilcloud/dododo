module Commands.ListTasks
  ( allStdOut,
    allStdOutWithStatus,
    allStdOutWithoutStatus,
  )
where

import Data.List (intercalate)
import qualified Filter
import qualified Task
import qualified TasksIO

printTasks :: [Task.Task] -> IO ()
printTasks tasks = putStr $ concat (map Task.formatTask tasks)

-- Function to print all tasks to stdout
allStdOut :: IO ()
allStdOut = do
  tasks <- TasksIO.getAllTasksFromCurrent
  let tasksWithStatus = filter Filter.taskWithStatus tasks
  let tasksWithoutStatus = filter Filter.taskWithoutStatus tasks
  printTasks tasksWithStatus
  putStrLn "\n"
  printTasks tasksWithoutStatus
  putStrLn "\n"

-- Function to print all tasks with a status to stdout
allStdOutWithStatus :: IO ()
allStdOutWithStatus = do
  tasks <- TasksIO.getAllTasksFromCurrent
  let tasksWithStatus = filter Filter.taskWithStatus tasks
  printTasks tasksWithStatus

-- Function to print all tasks without a status to stdout
allStdOutWithoutStatus :: IO ()
allStdOutWithoutStatus = do
  tasks <- TasksIO.getAllTasksFromCurrent
  let tasksWithoutStatus = filter Filter.taskWithoutStatus tasks
  printTasks tasksWithoutStatus
