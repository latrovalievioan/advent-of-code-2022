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

  let solution1 = solve1 $ moveStacks instructions inputStacks 0
  
  -- let test = moveStep ["DD", "RRRRRRRRRRRRR"] [13, 2, 1]
  -- let test1 = moveStep test [12, 1, 2]
  -- print test1

  print solution1

  where
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

    moveStep :: [String] -> [Int] -> [String]
    moveStep xs [count, from, to]
      | count == 0 = xs
      | otherwise = moveStep (mapInd (\x i -> 
        if i == from - 1
        then snd $ pop $ xs !! i
        else if i == to - 1
        then push (xs !! i) (fst $ pop $ xs !! (from - 1))
        else x
      ) xs) [(count - 1), from, to]

    moveStacks :: [[Int]] -> [String] -> Int -> [String]
    moveStacks instructions stacks i
      | i == length instructions = stacks 
      | otherwise = moveStacks instructions (moveStep stacks (instructions !! i)) (i + 1)

    solve1 :: [String] -> String
    solve1 = map (\x -> last x)

