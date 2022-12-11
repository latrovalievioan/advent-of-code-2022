import System.IO  
import Data.List
import Debug.Trace

dbg :: Show a => a -> a
dbg x = trace (show x) x

main :: IO ()
main = do
  s <- lines <$> readFile "input1"
  let input = map(\x -> words x) (init s)

  let startingCanvas = ["........................................",
                        "........................................",
                        "........................................",
                        "........................................",
                        "........................................",
                        "........................................"]

  -- let solution1 = solve1 0 input 220 0 (1, [])

  -- print solution1
  
  let (line1, next) = drawLine input 0 39 (1, []) "........................................"
  let (line2, next2) = drawLine input 40 79 next "........................................"
  let (line3, next3) = drawLine input 80 119 next2 "........................................"
  let (line4, next4) = drawLine input 120 159 next3 "........................................"
  let (line5, next5) = drawLine input 160 219 next4 "........................................"

  print line1
  print line2
  print line3
  print line4
  print line5



  where
    drawLine :: [[String]] -> Int -> Int -> (Int, [(Int, Int)]) -> String -> (String, (Int, [(Int, Int)]))
    drawLine instructions i to (spritePosition, queue) line
      | i > to = (line, (spritePosition, queue))
      | otherwise = drawLine instructions (i + 1) to  (cycle i instructions (spritePosition, queue)) (updateLine (i - 1) spritePosition line)

    updateLine :: Int -> Int -> String -> String
    updateLine crt spritePosition line
      | absoluteCrt == absoluteSpritePosition - 1 || absoluteCrt == absoluteSpritePosition || absoluteCrt == absoluteSpritePosition + 1 = replace absoluteCrt '#' line
      | otherwise = line
        where
          absoluteSpritePosition = spritePosition `mod` 40
          absoluteCrt = crt `mod` 40
  
    replace :: Int -> Char -> String -> String
    replace pos newVal list = take pos list ++ newVal : drop (pos+1) list

    solve1 :: Int -> [[String]] -> Int -> Int -> (Int, [(Int, Int)]) -> Int
    solve1 endValue instructions to i (value, queue)
      | i > to = endValue
      | i == 20 || i == 60 || i == 100 || i == 140 || i == 180 || i == 220 =
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
