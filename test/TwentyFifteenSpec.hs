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

day2_test :: Test
day2_test = TestLabel "Day 2 Tests" $ TestList $ map (\(input, output) -> TestCase $ assertEqual input output $ day2 input) [
        ("2x3x4", 58),
        ("1x1x10", 43)
    ]

day2_part2_test :: Test
day2_part2_test = TestLabel "Day 2 Part 2 Tests" $ TestList $ map (\(input, output) -> TestCase $ assertEqual input output $ day2_part2 input) [
        ("2x3x4", 34),
        ("1x1x10", 14)
    ]

twentyFifteenTests :: Test
twentyFifteenTests = TestLabel "2015 Tests" $ TestList [day1_test, day1_part2_test, day2_test, day2_part2_test]
