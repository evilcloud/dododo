module Task.Filter (isCompleted) where

import qualified Collection.Filter as CF
import Task.Model (Micro (..), Status (..), Task (..), Tomorrow (..))

isCompleted :: Task -> Bool
isCompleted (MicroTask micro) = status micro /= ""
isCompleted (TomorrowTask tomorrow) = isDone tomorrow == Done

findLatestOpenTask :: IO (Maybe Task)
findLatestOpenTask = do
  tasks <- CF.incompleteMicro
  let openTasks = filter (not . isCompleted) tasks
  return $
    if null openTasks
      then Nothing
      else Just $ maximumBy (comparing getCreationTime) openTasks
