module Commands.Help where

helpText :: String
helpText =
  unlines
    [ "Usage: dododo [COMMAND] [OPTIONS]",
      "",
      "Available commands:",
      "",
      "  shell",
      "      Start a new shell session",
      "",
      "  new 'task message'",
      "      Create a new task",
      "",
      "  task 'task id'",
      "      Find and print task by id",
      "",
      "  done 'task id' 'status'",
      "      Mark a task as done. If task id is provided, it will mark that task as done.",
      "      If status is also provided, it will mark that task with that status. If no arguments are provided,",
      "      it will mark the last task with done. If only task id is provided, it will mark last task with that status.",
      "",
      "  undone 'task id'",
      "      Mark a task as undone. If task id is provided, the status will be removed from that task.",
      "      If no arguments are provided, the status will be removed from the last task with status.",
      "",
      "  delete 'task id'",
      "      Delete a task. If task id is provided, that task will be deleted.",
      "",
      "  edit",
      "      Open current tasks in a default editor. If 'editor name' is provided, that editor will be used to open the file.",
      "",
      "  editor 'editor name'",
      "      Set a new default editor",
      "",
      "  config",
      "      Open config.ini in a default editor. If 'editor name' is provided, the config file will be opened with that editor.",
      "",
      "  reset",
      "      Reset the configuration to default values",
      "",
      "  help",
      "      Show this help text"
    ]

printHelp :: [String] -> IO ()
printHelp _ = putStrLn helpText
