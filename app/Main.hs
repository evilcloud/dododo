import qualified Commands.CommandList as CommandList
import qualified Commands.Shell as Shell
import qualified Config.Config as Conf
import qualified Sync.Dropbox as Dropbox
import System.Environment (getArgs)
import qualified TaskArchiver

main :: IO ()
main = do
  TaskArchiver.archiveOldTasks
  putStrLn "\nDoDoDo"
  putStrLn "\n"
  args <- getArgs
  case args of
    ("dropbox" : args) -> Dropbox.findDropboxDirs args
    ("conf" : _) -> Conf.loadOrRestoreConfigIO
    ("reset" : _) -> Conf.resetToDefault
    ("sync" : args) -> Conf.enterSync (unwords args)
    ("shell" : _) -> Shell.shellLoop
    _ -> CommandList.processCommand args
