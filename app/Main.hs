-- Main.hs

import qualified Commands.Delete as Delete
import qualified Commands.Help as Help
import qualified Commands.ListTasks as ListTasks
import qualified Commands.New as New
import qualified Commands.Status as Status
import qualified Config
import Control.Monad (void)
-- import Data.List (elem)
import qualified Data.Map as M
import Data.Maybe (fromMaybe)
import qualified FindTask
import qualified LastTask
import System.Environment (getArgs)
import qualified TaskArchiver

main :: IO ()
main = do
  TaskArchiver.archiveOldTasks
  args <- getArgs
  case args of
    [] -> ListTasks.allStdOut
    _ -> do
      let (command : args') = args
      let options = fromMaybe [] (M.lookup command Config.commandOptions)
      let matchOption x = x `elem` options
      case command of
        x | matchOption x ->
          case command of
            "new" -> void $ New.new (unwords args')
            "task" -> FindTask.findAndPrintTaskById (head args')
            "status" -> Status.changeStatus (head args') (unwords (tail args'))
            "done" -> Status.changeStatus (head args') "done"
            "last" -> LastTask.statusLastOpen (unwords args')
            "unlast" -> LastTask.openLastStatus
            "delete" -> Delete.deleteTasks args'
            _ -> putStrLn "Unknown command"
        "help" -> Help.printHelp
        _ -> putStrLn "Unknown command"
