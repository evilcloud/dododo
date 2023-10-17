module Printer.Forms
  ( normalComment,
  )
where

normalComment :: String -> IO ()
normalComment comment = do
  putStrLn ""
  putStrLn comment
  putStrLn ""

normalComment :: [String] -> String
normalComment commentLines = normalComment $ unilines commentLines