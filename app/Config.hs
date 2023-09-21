{-# LANGUAGE OverloadedStrings #-}

module Config
  ( current,
    past,
    lifetime,
    taskInternalSeparator,
    commandOptions,
  )
where

import qualified Data.Map as M

commandOptions :: M.Map String [String]
commandOptions =
  M.fromList
    [ ("new", ["new", "create", "add"]),
      ("task", ["task", "find", "search"]),
      ("status", ["status", "update", "change"]),
      ("done", ["done", "completed", "complete", "close", "closed", "finish", "finished"]),
      ("open", ["open", "reopen"]),
      ("last", ["last"]),
      ("delete", ["delete", "remove"]),
      ("unlast", ["unlast", "reopen", "undo"]),
      ("help", ["help", "h", "?"]),
      ("editor", ["editor"]),
      ("config", ["config", "editconfig"])
    ]

-- Paths to the files with current tasks and tasks beyond lifetime
current, past :: String
current = "~/.local/share/dododo/current.txt"
past = "~/.local/share/dododo/past.txt"

-- Lifetime of a task in days
lifetime :: String
lifetime = "7"

-- Task internal separator
taskInternalSeparator :: String
taskInternalSeparator = "  |  "
