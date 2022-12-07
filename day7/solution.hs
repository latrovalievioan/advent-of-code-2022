import System.IO  
import Data.List.Split
import Data.List
import Data.Char (ord)
import Data.Maybe
import qualified Data.Map.Strict as M

type Tree = M.Map [String] [(String, Int)]

main :: IO ()
main = do
  s <- splitOn "\n" <$> readFile "input1"
  let input = map (\x -> words x) (init s)
  
  let (tree, _) = foldl' step (M.empty, []) input
  let sizes = calcSize tree ["/"]

  let solution1 = sum . filter(<=100000) . map snd . M.toList $ sizes

  let freeSpace = 70000000 - (fromMaybe 0 $ M.lookup ["/"] sizes)

  let candidates = filter (\x -> x + freeSpace >= 30000000) . map snd . M.toList $ sizes

  print solution1
  print $ minimum candidates
  print $ map snd . M.toList $ sizes

  where
    step :: (Tree, [String]) -> [String] -> (Tree, [String])
    step (tree, stack) cmd = case cmd of
        ["$", "cd", ".."] -> (tree, tail stack)
        ["$", "cd", dir] -> (tree, dir:stack)
        ["$", "ls"] -> (tree, stack)
        ["dir", dirName] -> (M.insertWith (++) stack [(dirName, 0)] $ M.insert (dirName:stack) [] tree, stack)
        [size, fileName] -> (M.insertWith (++) stack [(fileName, read size)] tree, stack)

    calcSize :: Tree -> [String] -> M.Map [String] Int
    calcSize tree start =
      case M.lookup start tree of
        Just files -> 
          let sizes = foldl' calcStep M.empty files 
              startSize = sum $ map (\(k, _) -> sizes M.! (k:start)) files :: Int
              withStart = M.insert start startSize sizes
          in M.intersection withStart tree
        Nothing -> undefined
        where
          calcStep acc (name, size) = M.union acc $ if size == 0 then calcSize tree (name:start) else M.singleton (name:start) size
          sizesSum = sum . map snd . M.toList
