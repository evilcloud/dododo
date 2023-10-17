{-# LANGUAGE OverloadedStrings #-}

module Test.Task
  ( tests,
  )
where

import Control.Monad
import Data.Time
import Task.Format
import Task.Task
import Test.HUnit

printFormattedTask :: String -> Task -> IO ()
printFormattedTask testName task = do
  --   putStrLn "\n"
  putStrLn $ testName ++ ": "
  putStrLn . taskForFile $ task
  putStrLn "\n"

testcreateMicroTask :: Test
testcreateMicroTask = TestCase $ do
  task <- createMicroTask "Test microtask"
  assertEqual "Task message should match" "Test microtask" (message task)
  assertBool "Task id should not be empty" (not . null $ taskId task)
  printFormattedTask "testcreateMicroTask" task

testCreateTomorrowTask :: Test
testCreateTomorrowTask = TestCase $ do
  task <- createTomorrowTask "Test tomorrowtask"
  assertEqual "Task message should match" "Test tomorrowtask" (message task)
  assertBool "Task id should not be empty" (not . null $ taskId task)
  printFormattedTask "testCreateTomorrowTask" task

testupdateMicroTask :: Test
testupdateMicroTask = TestCase $ do
  task <- createMicroTask "Test microtask"
  updatedTask <- updateMicroTask task "completed"
  assertEqual "Task status should be updated" (Just "completed") (status updatedTask)
  printFormattedTask "testupdateMicroTask" updatedTask

testUpdateTomorrowTask :: Test
testUpdateTomorrowTask = TestCase $ do
  task <- createTomorrowTask "Test tomorrowtask"
  updatedTask <- updateTomorrowTask task
  --   assertEqual "Task todoChecked should be updated" True (todoChecked updatedTask)
  printFormattedTask "testUpdateTomorrowTask" updatedTask

testFormatVariousTasks :: Test
testFormatVariousTasks = TestCase $ do
  microtask <- createMicroTask "Test microtask"
  updatedMicrotask <- updateMicroTask microtask (Just "completed")
  tomorrowtask <- createTomorrowTask "Test tomorrowtask"
  updatedTomorrowtask <- updateTomorrowTask tomorrowtask

  let tasks = [("microtask", microtask), ("updatedMicrotask", updatedMicrotask), ("tomorrowtask", tomorrowtask), ("updatedTomorrowtask", updatedTomorrowtask)]

  forM_ tasks $ \(testName, task) -> printFormattedTask testName task

tests :: Test
tests =
  TestList
    [ testcreateMicroTask,
      testCreateTomorrowTask,
      testupdateMicroTask,
      testUpdateTomorrowTask,
      testFormatVariousTasks
    ]
