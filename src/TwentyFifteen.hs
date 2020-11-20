module TwentyFifteen
    ( day1
    , day1_part2
    , day2
    , day2_part2
    ) where

import Data.List.Split ( splitOn )

day1 :: String -> Int
day1 = foldl (\acc c -> case c of
        '(' -> acc + 1
        ')' -> acc - 1
        _ -> acc
    ) 0

day1_part2 :: String -> Int
day1_part2 chars = if snd res then fst res else length chars where
    res = foldl (\(acc, done) (i, c) -> if acc < 0 then (i, True) else if done then (acc, True) else (case c of
            '(' -> acc + 1
            ')' -> acc - 1
            _ -> acc
        , False)) (0, False) (zip [0..] chars)

day2_calc_paper :: [Int] -> Int
day2_calc_paper (l:w:h:_) = 2*l*w + 2*l*h + 2*w*h + min (min (l*w) (l*h)) (w*h)

day2_calc_ribbon :: [Int] -> Int
day2_calc_ribbon (l:w:h:_) = min (min (2*l+2*w) (2*l+2*h)) (2*w+2*h) + l*w*h

day2_parse_dims :: String -> [Int]
day2_parse_dims s = map read $ splitOn "x" s

day2 :: String -> Int
day2 file = sum $ map (day2_calc_paper.day2_parse_dims) $ lines file

day2_part2 :: String -> Int
day2_part2 file = sum $ map (day2_calc_ribbon.day2_parse_dims) $ lines file
