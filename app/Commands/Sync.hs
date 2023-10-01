module Commands.Sync where

import qualified Sync.Sync as Sync

syncCommand :: [String] -> IO ()
syncCommand [] = Sync.findSyncDirs Sync.syncDirs
syncCommand ["off"] = Sync.disableSync
syncCommand (dir : _) = Sync.findSyncDirs [dir]
