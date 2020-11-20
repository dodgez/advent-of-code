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

day3_test :: Test
day3_test = TestLabel "Day 3 Tests" $ TestList $ map (\(input, output) -> TestCase $ assertEqual input output $ day3 input) [
        (">", 2),
        ("^>v<", 4),
        ("^v^v^v^v^v", 2)
    ]

day3_part2_test :: Test
day3_part2_test = TestLabel "Day 3 Part 2 Tests" $ TestList $ map (\(input, output) -> TestCase $ assertEqual input output $ day3_part2 input) [
        ("^v", 3),
        ("^>v<", 3),
        ("^v^v^v^v^v", 11)
    ]

twentyFifteenTests :: Test
twentyFifteenTests = TestLabel "2015 Tests" $ TestList [day1_test, day1_part2_test, day2_test, day2_part2_test, day3_test, day3_part2_test]
