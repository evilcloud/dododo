module Commands.Help
  ( printHelp,
  )
where

printHelp :: IO ()
printHelp = do
  putStrLn "\nDododo - the microtask manager\nGoals over tasks\n"
  putStrLn "HELP\n"
  putStrLn "Commands:\n"
  putStrLn "  new <task description>"
  putStrLn "    Creates a new task with the given description.\n"
  putStrLn "  task <taskId>"
  putStrLn "    Finds and prints the task with the given ID.\n"
  putStrLn "  status <taskId> <new status>"
  putStrLn "    Changes the status of the task with the given ID to the new status.\n"
  putStrLn "  last <new status>"
  putStrLn "    Changes the status of the latest open task to the new status.\n"
  putStrLn "  unlast"
  putStrLn "    Changes the status of the latest task that is not open to 'open'.\n"
  putStrLn "If no commands are given, all tasks are listed.\n"
  putStrLn "Unknown commands will result in a 'Unknown command' message and display this help screen.\n"
