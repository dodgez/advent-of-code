module TwentyFifteen where

import Data.Digest.Pure.MD5 (md5)
import Data.List (isInfixOf, isPrefixOf)
import Data.List.Split (splitOn)
import qualified Data.Map as M
import Data.String (IsString (fromString))

day1 :: String -> Int
day1 =
  foldl
    ( \acc c -> case c of
        '(' -> acc + 1
        ')' -> acc - 1
        _ -> acc
    )
    0

day1_part2 :: String -> Int
day1_part2 chars = if snd res then fst res else length chars
  where
    res =
      foldl
        ( \(acc, done) (i, c) ->
            if acc < 0
              then (i, True)
              else
                if done
                  then (acc, True)
                  else
                    ( case c of
                        '(' -> acc + 1
                        ')' -> acc - 1
                        _ -> acc,
                      False
                    )
        )
        (0, False)
        (zip [0 ..] chars)

day2_calc_paper :: [Int] -> Int
day2_calc_paper (l : w : h : _) = 2 * l * w + 2 * l * h + 2 * w * h + min (min (l * w) (l * h)) (w * h)

day2_calc_ribbon :: [Int] -> Int
day2_calc_ribbon (l : w : h : _) = min (min (2 * l + 2 * w) (2 * l + 2 * h)) (2 * w + 2 * h) + l * w * h

day2_parse_dims :: String -> [Int]
day2_parse_dims s = map read $ splitOn "x" s

day2 :: String -> Int
day2 file = sum $ map (day2_calc_paper . day2_parse_dims) $ lines file

day2_part2 :: String -> Int
day2_part2 file = sum $ map (day2_calc_ribbon . day2_parse_dims) $ lines file

day3_update_map :: (M.Map (Int, Int) Int, (Int, Int)) -> (Int, Int) -> (M.Map (Int, Int) Int, (Int, Int))
day3_update_map (m, (x, y)) (dx, dy) = let new_pos = (x + dx, y + dy); v = M.findWithDefault 0 new_pos m in (M.insert new_pos (v + 1) m, (x + dx, y + dy))

day3_parse_direction :: Char -> (Int, Int)
day3_parse_direction c = case c of
  '^' -> (0, 1)
  '>' -> (1, 0)
  'v' -> (0, -1)
  '<' -> (-1, 0)
  _ -> (0, 0)

day3 :: String -> Int
day3 input = M.size $ M.filter (> 0) $ fst $ foldl day3_update_map (M.fromList [((0, 0), 1)], (0, 0)) (map day3_parse_direction input)

day3_part2 :: String -> Int
day3_part2 input = M.size $ M.filter (> 0) $ second_result
  where
    first_result = foldl day3_update_map (M.fromList [((0, 0), 2)], (0, 0)) (map (day3_parse_direction . snd) $ filter (even . fst) $ zip [0 ..] input)
    second_result = fst $ foldl day3_update_map (fst first_result, (0, 0)) (map (day3_parse_direction . snd) $ filter (odd . fst) $ zip [0 ..] input)

day4_check_num :: Int -> String -> Int -> Bool
day4_check_num n s i = let input = fromString $ s ++ show i in concat (replicate n "0") `isPrefixOf` show (md5 input)

day4_stub :: Int -> String -> Int
day4_stub n s = head $ filter (day4_check_num n s) [1..]

day4 :: String -> Int
day4 = day4_stub 5

day4_part2 :: String -> Int
day4_part2 = day4_stub 6

day5_nice_vowels :: String -> Bool
day5_nice_vowels s = (>2) (length $ filter (`elem` "aeiou") s)

day5_nice_repeats :: String -> Bool
day5_nice_repeats (x:y:ys) = x == y || day5_nice_repeats (y:ys)
day5_nice_repeats _ = False

day5_nice_words :: String -> Bool
day5_nice_words s = all (not . flip isInfixOf s) ["ab", "cd", "pq", "xy"]

day5_ind :: String -> Bool
day5_ind s = all (\f -> f s) [day5_nice_vowels, day5_nice_repeats, day5_nice_words]

day5 :: String -> Int
day5 s = length $ filter day5_ind $ lines s
