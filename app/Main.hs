import qualified Commands.Commands as Commands
import qualified Commands.Shell as Shell
-- import qualified Config.Config as Config
import System.Environment (getArgs)

main :: IO ()
main = do
  putStrLn "\nDoDoDo"
  putStrLn "\n"
  args <- getArgs
  case args of
    ("shell" : _) -> Shell.shellLoop
    _ -> Commands.processCommand args

-- import Test.HUnit
-- import qualified Test.Task

-- main :: IO ()
-- main = do
--   _ <- runTestTT Test.Task.tests
--   return ()
