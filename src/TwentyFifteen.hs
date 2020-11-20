module TwentyFifteen
    ( day1
    , day1_part2
    ) where

day1 :: String -> Int
day1 chars = foldl (\acc c -> case c of
        '(' -> acc + 1
        ')' -> acc - 1
        otherwise -> acc
    ) 0 chars

day1_part2 :: String -> Int
day1_part2 chars = if snd res then fst res else length chars where
    res = foldl (\(acc, done) (i, c) -> if acc < 0 || done then (i, True) else (case c of
            '(' -> acc + 1
            ')' -> acc - 1
            otherwise -> acc
        , False)) (0, False) (zip [0..] chars)


