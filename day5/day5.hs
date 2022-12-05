import System.IO  
import Data.List.Split
import Data.List
import Data.Char (ord)

main :: IO ()
main = do
  s <- splitOn "\n" <$> readFile "input1"
  let input = map (\x -> words x) (init s)
  let instructions = map (\x -> toInts $ filterEmpty $ swapWords x) input
  let testStacks = ["ZN","MCD","P"]
  
  let inputStacks = ["TDWZVP", "LSWVFJD", "ZMLSVTBH", "RSJ", "CZBGFMLW", "QWVHZRGB", "VJPCBDN", "PTBQ", "HGZRC"]

  let solution1 = solve $ moveStacks1 instructions inputStacks 0
  let solution2 = solve $ moveStacks2 instructions inputStacks 0

  print solution1
  print solution2

  where
    lastN :: Int -> [a] -> [a]
    lastN n xs = drop (length xs - n) xs

    mapInd :: (a -> Int -> b) -> [a] -> [b]
    mapInd f l = zipWith f l [0..]

    swapWords :: [String] -> [String]
    swapWords = mapInd (\x i -> if i `mod` 2 == 0 then "" else x)
    
    filterEmpty :: [String] -> [String]
    filterEmpty = filter (\x -> x /= "")

    toInts :: [String] -> [Int]
    toInts = map(\x -> read x :: Int)

    push :: String -> String -> String
    push xs v = xs ++ v

    pop :: String -> (String, String)
    pop xs = ([last xs], init xs)

    moveStep1 :: [String] -> [Int] -> [String]
    moveStep1 xs [count, from, to]
      | count == 0 = xs
      | otherwise = moveStep1 (mapInd (\x i -> 
        if i == from - 1
        then snd $ pop $ xs !! i
        else if i == to - 1
        then push (xs !! i) (fst $ pop $ xs !! (from - 1))
        else x
      ) xs) [(count - 1), from, to]

    moveStacks1 :: [[Int]] -> [String] -> Int -> [String]
    moveStacks1 instructions stacks i
      | i == length instructions = stacks 
      | otherwise = moveStacks1 instructions (moveStep1 stacks (instructions !! i)) (i + 1)

    solve :: [String] -> String
    solve = map (\x -> last x)

    moveStep2 :: [String] -> [Int] -> [String]
    moveStep2 xs [count, from, to] = mapInd (\x i -> if i == from - 1 then take (length x - count) x else if i == to - 1 then push x (lastN count (xs !! (from -1))) else x) xs

    moveStacks2 :: [[Int]] -> [String] -> Int -> [String]
    moveStacks2 instructions stacks i
      | i == length instructions = stacks 
      | otherwise = moveStacks2 instructions (moveStep2 stacks (instructions !! i)) (i + 1)
