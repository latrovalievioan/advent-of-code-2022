import System.IO  
import Data.List.Split
import Data.List
import Data.Char (ord)

main :: IO ()
main = do
  s <- readFile "input"
  let input = init s

  let solution1 = 4 + (length $ takeWhile (\x -> not $ checkUniques x) $ splitStrings 4 input)
  let solution2 = 14 + (length $ takeWhile (\x -> not $ checkUniques x) $ splitStrings 14 input)

  print solution1
  print solution2

  where
    checkUniques :: String -> Bool
    checkUniques str = length  (nub  str) == (length str)

    splitStrings :: Int -> [a] -> [[a]]
    splitStrings _ [] = []
    splitStrings n xs = filter (\x -> length x == n) list
      where list = take n xs : splitStrings n (drop 1 xs)
