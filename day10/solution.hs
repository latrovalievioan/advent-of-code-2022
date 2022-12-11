import System.IO  
import Data.List

main :: IO ()
main = do
  s <- lines <$> readFile "input1"
  let input = map words $ init s

  let solution1 = solve1 0 input 220 0 (1, [])

  print solution1

  where
    solve1 :: Int -> [[String]] -> Int -> Int -> (Int, [(Int, Int)]) -> Int
    solve1 endValue instructions to i (value, queue)
      | i > to = endValue
      | i `mod` 40 == 20 =
        solve1 (endValue + i * value) instructions to (i + 1) (cycle i instructions (value, queue))
      | otherwise = solve1 endValue instructions to (i + 1) (cycle i instructions (value, queue))

    cycle :: Int -> [[String]] -> (Int, [(Int, Int)]) -> (Int, [(Int, Int)])
    cycle i instructions (value, queue)
      | i > (length instructions) - 1 = (updatedValue, updatedQueue)
      | (instructions !! i) !! 0 == "noop" = (updatedValue, (updatedQueue ++ [(1,0)]))
      | otherwise = (updatedValue, updatedQueue ++ [(2, read $ (instructions !! i) !! 1)])
        where
          (updatedValue, updatedQueue) = update (value, queue)

    update :: (Int, [(Int, Int)]) -> (Int, [(Int, Int)])
    update (value, []) = (value, [])
    update (value, (timer, increment):tail)
      | timer - 1 == 0 = (value + increment, tail)
      | otherwise = (value, (timer - 1, increment):tail)
