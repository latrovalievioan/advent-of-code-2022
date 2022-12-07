import System.IO  
import Data.List.Split
import Data.List
import Data.Char (ord)

main :: IO ()
main = do
  s <- splitOn "\n" <$> readFile "input1"
  let input = init s

  let part1 = foldl' step 0 input
  print part1
  
  let chunked = chunksOf 3 input

  let commons = map head (map nub (map findCommon3 chunked))

  let part2 = foldl' (\acc curr -> acc + priority curr) 0 commons

  print part2
  
  where
    step :: Int -> String -> Int
    step acc curr = acc + (priority $ findCommon $ halve curr)

    findCommon :: (String, String) -> Char
    findCommon (xs, ys) = head $ filter (\x -> x `elem` ys) xs

    findCommon3 [a, b, c] = filter(\x -> (x `elem` b) && (x `elem` c)) a

    priority :: Char -> Int
    priority x
      | ord x >= 97 = ord x - 96
      | otherwise = ord x + 26 - 64

    halve :: String -> (String, String)
    halve word = splitAt (length word `div` 2) word
