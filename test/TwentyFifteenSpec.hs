module TwentyFifteenSpec
    ( twentyFifteenTests
    ) where

import Test.HUnit

import TwentyFifteen

day1_test :: Test
day1_test = TestLabel "Day 1 Tests" $ TestList $ map (\(input, output) -> TestCase $ assertEqual input output $ day1 input) [
        ("(())", 0),
        ("()()", 0),
        ("(((", 3),
        ("(()(()(", 3),
        ("))(((((", 3),
        ("())", -1),
        ("))(", -1),
        (")))", -3),
        (")())())", -3)
    ]

day1_part2_test :: Test
day1_part2_test = TestLabel "Day 1 Part 2 Tests" $ TestList $ map (\(input, output) -> TestCase $ assertEqual input output $ day1_part2 input) [
        (")", 1),
        ("()())", 5)
    ]

twentyFifteenTests :: Test
twentyFifteenTests = TestLabel "2015 Tests" $ TestList [day1_test, day1_part2_test]
