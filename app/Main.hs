import qualified Commands.Commands as Commands
import qualified Commands.Shell as Shell
import qualified Help.Commands as HelpCommands
import qualified Printer.Print as Print
import System.Environment (getArgs)

main :: IO ()
main = do
  Print.normalComment "DoDoDo"
  args <- getArgs
  case args of
    ("shell" : "help" : _) -> HelpCommands.getHelp "shell"
    ("shell" : _) -> Shell.shellLoop
    _ -> Commands.processCommand args
