module TasksArray.List
  ( allStdOut,
    allStdOutWithStatus,
    allStdOutWithoutStatus,
  )
where

import Data.List (intercalate)
import qualified Handlers.Filter as Filter
import qualified Task.Task as Task
import qualified TasksArray.TasksIO as TasksIO
import Text.Printf (printf)
import qualified TimeMachine

-- Function to calculate the maximum timestamp length
maxTimestampLength :: [Task.Task] -> IO Int
maxTimestampLength tasks = do
  casualTimestamps <- mapM (TimeMachine.casualTime . Task.creationTimestamp) tasks
  return $ maximum $ map length casualTimestamps

-- Function to pad a string to a given length
padString :: Int -> String -> String
padString len str = printf ("%- " ++ show len ++ "s") str

-- Function to format a task with casual time and padding
formatTaskWithCasualTime :: Int -> Task.Task -> IO String
formatTaskWithCasualTime maxLen task = do
  casualTimestamp <- TimeMachine.casualTime $ Task.creationTimestamp task
  let paddedTimestamp = padString maxLen casualTimestamp
  let taskWithCasualTime = task {Task.creationTimestamp = paddedTimestamp}
  return $ Task.formatTask taskWithCasualTime

-- Function to print tasks after applying a transformation
printTasks :: (Task.Task -> IO String) -> [Task.Task] -> IO ()
printTasks transform tasks = do
  formattedTasks <- mapM transform tasks
  putStr $ intercalate "\n" formattedTasks

-- Function to print all tasks to stdout
allStdOut :: IO ()
allStdOut = do
  tasks <- TasksIO.getAllTasksFromCurrent
  maxLen <- maxTimestampLength tasks
  let tasksWithStatus = filter Filter.taskWithStatus tasks
  let tasksWithoutStatus = filter Filter.taskWithoutStatus tasks
  printTasks (formatTaskWithCasualTime maxLen) tasksWithStatus
  putStrLn "\n"
  printTasks (formatTaskWithCasualTime maxLen) tasksWithoutStatus
  putStrLn "\n"

-- Function to print all tasks with a status to stdout
allStdOutWithStatus :: IO ()
allStdOutWithStatus = do
  tasks <- TasksIO.getAllTasksFromCurrent
  maxLen <- maxTimestampLength tasks
  let tasksWithStatus = filter Filter.taskWithStatus tasks
  printTasks (formatTaskWithCasualTime maxLen) tasksWithStatus

-- Function to print all tasks without a status to stdout
allStdOutWithoutStatus :: IO ()
allStdOutWithoutStatus = do
  tasks <- TasksIO.getAllTasksFromCurrent
  maxLen <- maxTimestampLength tasks
  let tasksWithoutStatus = filter Filter.taskWithoutStatus tasks
  printTasks (formatTaskWithCasualTime maxLen) tasksWithoutStatus
