module TaskArchiver
  ( archiveOldTasks,
  )
where

import qualified Config.Config as Config
import Control.Monad (unless)
import Data.List (partition)
import Data.Time.Clock
import Data.Time.LocalTime (LocalTime, utc, utcToLocalTime)
import qualified FileManager
import qualified Task.Task as Task
import qualified TasksArray.TasksIO as TasksIO
import qualified Timestamp

-- Function to check if a task is older than Config.lifetime days
isOld :: LocalTime -> Task.Task -> Bool
isOld now task =
  let taskTimestamp = Timestamp.parseTimestamp $ Task.creationTimestamp task
   in case taskTimestamp of
        Just ts ->
          let taskAge = Timestamp.diffLocalTime now ts
              lifetimeSecs = (fromIntegral $ (read Config.lifetime :: Int) * 24 * 60 * 60)
           in taskAge > lifetimeSecs
        Nothing -> False

-- Function to archive old tasks from current to past
archiveOldTasks :: IO ()
archiveOldTasks = do
  now <- getCurrentTime
  let localNow = utcToLocalTime utc now
  tasks <- TasksIO.getAllTasksFromCurrent
  let (oldTasks, currentTasks) = partition (isOld localNow) tasks
  mapM_ TasksIO.addTaskToPast oldTasks
  mapM_ TasksIO.deleteTaskInCurrent (map Task.taskId oldTasks)
  unless (null oldTasks) $ do
    putStrLn $ "Tasks removed from the list: " ++ show (length oldTasks)
    mapM_ (putStrLn . Task.formatTask) oldTasks
    putStrLn $ "\n\n"
