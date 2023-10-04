module Config.CommandOptions
  ( commandOptions,
  )
where

import qualified Data.Map as Map

commandOptions :: Map.Map String [String]
commandOptions =
  Map.fromList
    [ ("new", ["new", "create", "add"]),
      ("task", ["task", "find", "search"]),
      ("status", ["status", "update", "change"]),
      ("done", ["done", "completed", "complete", "close", "closed", "finish", "finished"]),
      ("open", ["open", "reopen"]),
      ("delete", ["delete", "remove"]),
      ("undone", ["undone", "unlast", "reopen", "undo"]),
      ("help", ["help", "h", "?"]),
      ("editor", ["editor"]),
      ("edit", ["edit"]),
      ("config", ["config", "editconfig"])
    ]
