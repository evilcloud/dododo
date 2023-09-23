import qualified Commands.CommandList as CommandList
import qualified Commands.Shell as Shell
import System.Environment (getArgs)
import qualified TaskArchiver

main :: IO ()
main = do
  TaskArchiver.archiveOldTasks
  putStrLn "\nDoDoDo"
  putStrLn "\n"
  args <- getArgs
  case args of
    ("shell" : _) -> do
      Shell.shellLoop
    _ -> CommandList.processCommand args
