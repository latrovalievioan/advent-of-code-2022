import System.IO  
import Data.List.Split
import Data.List
import Data.Char (ord)

main :: IO ()
main = do
  s <- splitOn "\n" <$> readFile "input0"
  let input = map (\x -> words x) (init s)

  print input

  where
    -- step acc curr = 

    -- generateThree = foldl step []

