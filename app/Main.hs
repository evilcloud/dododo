import qualified Commands.CommandList as CommandList
import qualified Commands.Shell as Shell
import System.Environment (getArgs)
import qualified TaskArchiver

main :: IO ()
main = do
  TaskArchiver.archiveOldTasks
  args <- getArgs
  case args of
    ("shell" : _) -> do
      putStrLn "DoDoDo shell. 'quit' to exit."
      Shell.shellLoop
    _ -> CommandList.processCommand args
