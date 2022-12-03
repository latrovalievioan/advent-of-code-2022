import System.IO  
import Data.List.Split
import Data.List
import Data.Char (ord)

main :: IO ()
main = do
  s <- splitOn "\n" <$> readFile "input_day3"
  let input = init s

  let result = foldl' step 0 input
  
  print result
  
  where
    step :: Int -> String -> Int
    step acc curr = acc + (priority $ findCommon $ halve curr)

    findCommon :: (String, String) -> Char
    findCommon (xs, ys) = head $ filter (\x -> x `elem` ys) xs

    priority :: Char -> Int
    priority x
      | ord x >= 97 = ord x - 96
      | otherwise = ord x + 26 - 64

    halve :: String -> (String, String)
    halve word = splitAt (length word `div` 2) word

