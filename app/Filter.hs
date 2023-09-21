module Filter
  ( taskWithStatus,
    taskWithoutStatus,
    findByTaskId,
    findLatestOpenTask,
    findLatestTaskWithStatus,
  )
where

import Data.Char (toLower)
import Data.List (find, maximumBy)
import Data.Ord (comparing)
import Data.Text (pack, strip, unpack)
import Task (Task (..))

-- Function to check if a task has a status
taskWithStatus :: Task -> Bool
taskWithStatus task = not (null $ status task) && status task /= "open"

-- Function to check if a task has no status
taskWithoutStatus :: Task -> Bool
taskWithoutStatus = not . taskWithStatus

-- Function to find a task by its taskId
findByTaskId :: [Task] -> String -> Maybe Task
findByTaskId tasks searchId =
  find (\task -> sanitize (taskId task) == sanitize searchId) tasks

-- Function to find the latest open task
findLatestOpenTask :: [Task] -> Maybe Task
findLatestOpenTask tasks =
  let openTasks = filter taskWithoutStatus tasks
   in if null openTasks
        then Nothing
        else Just $ maximumBy (comparing creationTimestamp) openTasks

-- Function to find the latest task with a status
findLatestTaskWithStatus :: [Task] -> Maybe Task
findLatestTaskWithStatus tasks =
  let tasksWithStatus = filter taskWithStatus tasks
   in if null tasksWithStatus
        then Nothing
        else Just $ maximumBy (comparing creationTimestamp) tasksWithStatus

-- Function to sanitize a string
sanitize :: String -> String
sanitize = map toLower . unpack . strip . pack
