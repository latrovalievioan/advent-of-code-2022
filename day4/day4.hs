import System.IO  
import Data.List.Split
import Data.List
import Data.Char (ord)

main :: IO ()
main = do
  s <- splitOn "\n" <$> readFile "input1"
  let input = init s

  let solution1 = solve1 $ sortRanges $ toRanges $ toNums $ parseRangeString $ parsePairs input

  print solution1

  where
    parsePairs :: [String] -> [[String]]
    parsePairs = map (\x -> splitOn "," x)

    parseRangeString :: [[String]] -> [[[String]]]
    parseRangeString = map (\x -> map(\y -> splitOn "-" y) x)

    toNums :: [[[String]]] -> [[[Int]]]
    toNums = map (\pair -> map (\t -> map (\x -> read x :: Int) t) pair)

    toRanges :: [[[Int]]] ->  [[[Int]]]
    toRanges = map (\p -> map (\t -> [head t .. head $ tail t]) p)

    compareElements :: [a] -> [a] -> Ordering
    compareElements x y = compare (length x) (length y)

    sortByLength :: [[a]] -> [[a]]
    sortByLength [] = []
    sortByLength (xs) = sortBy compareElements xs

    sortRanges :: [[[Int]]] -> [[[Int]]]
    sortRanges = map (\x -> sortByLength x)
    
    solve1 :: [[[Int]]] -> Int
    solve1 = foldl' (\acc [head, tail] -> 
      if (length $ intersect head tail) == length head 
      then acc + 1 
      else acc
      ) 0
