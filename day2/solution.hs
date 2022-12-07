import System.IO  
import Control.Monad
import Data.List.Split

getScore :: String -> Int
getScore line = case line of
  "A X" -> 4
  "A Y" -> 8
  "A Z" -> 3
  "B X" -> 1
  "B Y" -> 5
  "B Z" -> 9
  "C X" -> 7
  "C Y" -> 2
  "C Z" -> 6

getScore2 :: String -> Int
getScore2 line = case line of
  "A X" -> 3
  "A Y" -> 4
  "A Z" -> 8
  "B X" -> 1
  "B Y" -> 5
  "B Z" -> 9
  "C X" -> 2
  "C Y" -> 6
  "C Z" -> 7

main :: IO ()
main = do
  s <- splitOn "\n" <$> readFile "input_day2.txt"
  let input = init s

  let gg = sum $ map getScore input
  let gg2 = sum $ map getScore2 input

  print (gg, gg2)
