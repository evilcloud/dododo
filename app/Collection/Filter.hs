-- {-# LANGUAGE RecordWildCards #-}

module Collection.Filter where

import Data.List (sortBy)
import Data.Ord (comparing)
import Task.Access (getCreationTime)
import Task.Model (Micro (..), Status (..), Task (..), Tomorrow (..))

completedMicro :: [Task] -> [Task]
completedMicro tasks = sortTasks [MicroTask micro | MicroTask micro <- tasks, isCompleted (MicroTask micro)]

incompleteMicro :: [Task] -> [Task]
incompleteMicro tasks = sortTasks [MicroTask micro | MicroTask micro <- tasks, not (isCompleted (MicroTask micro))]

completedTomorrow :: [Task] -> [Task]
completedTomorrow tasks = sortTasks [TomorrowTask tomorrow | TomorrowTask tomorrow <- tasks, isCompleted (TomorrowTask tomorrow)]

incompleteTomorrow :: [Task] -> [Task]
incompleteTomorrow tasks = sortTasks [TomorrowTask tomorrow | TomorrowTask tomorrow <- tasks, not (isCompleted (TomorrowTask tomorrow))]

isCompleted :: Task -> Bool
isCompleted (MicroTask micro) = status micro /= ""
isCompleted (TomorrowTask tomorrow) = isDone tomorrow == Done

sortTasks :: [Task] -> [Task]
sortTasks = sortBy (comparing getCreationTime)