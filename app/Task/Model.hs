module Task.Model
  ( Task(..)
  ) where

import Data.Time

data Task = MicroTask
  { creation :: LocalTime
  , taskId :: String
  , message :: String
  , status :: Maybe String
  , duration :: Maybe NominalDiffTime
  } 
  | TomorrowTask
  { todoChecked :: Bool
  , taskId :: String
  , message :: String
  } deriving (Show, Eq)
