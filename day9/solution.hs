import System.IO  
import Data.List.Split
import Data.List
import Data.Char (ord)
import Data.Maybe
import qualified Data.Map.Strict as M


main :: IO ()
main = do
  s <- splitOn "\n" <$> readFile "input1"
  let input = map(\x -> words x) (init s)

  let stacks = foldl step1 ([(0, 0)], [(0, 0)]) input

  let solution1 = length $ nub $ snd stacks

  let (_, twoo, tree, _, five, six, theSeventh, theNotSoTailestTail, theTailestTail, naruto) = foldl step2 ([(0, 0)], [(0, 0)], [(0, 0)], [(0, 0)], [(0, 0)], [(0, 0)], [(0, 0)], [(0, 0)], [(0, 0)], [(0, 0)]) input

  let solution2 = length $ nub $ naruto

  print solution2
  where
    step1 :: ([(Int, Int)], [(Int, Int)]) -> [String] -> ([(Int, Int)], [(Int, Int)])
    step1 (hLast:hStack, tLast:tStack) curr = 
      let (newHStack, newTStack) = move ([hLast], [tLast]) (curr !! 0) (read $ curr !! 1)
      in (newHStack ++ hStack, newTStack ++ tStack)

    step2 :: ([(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)]) -> [String] -> ([(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)])
    step2 (hLast:hStack, oneLast:oneStack, twoLast:twoStack, treeLast:treeStack, fourLast:fourStack, fiveLast:fiveStack, sixLast:sixStack, sevenLast:sevenStack, eightLast:eightStack, tLast:tStack) curr =
      let (newHStack, newOneStack, newTwoStack, newTreeStack, newFourStack, newFiveStack, newSixStack, newSevenStack, newEightStack, newTStack) = move2 ([hLast], [oneLast], [twoLast], [treeLast], [fourLast], [fiveLast], [sixLast], [sevenLast], [eightLast], [tLast]) (curr !! 0) (read $ curr !! 1)
      in (newHStack ++ hStack, newOneStack ++ oneStack, newTwoStack ++ twoStack, newTreeStack ++ treeStack, newFourStack ++ fourStack, newFiveStack ++ fiveStack, newSixStack ++ sixStack, newSevenStack ++ sevenStack, newEightStack ++ eightStack, newTStack ++ tStack)

    checkTouching :: (Int, Int) -> (Int, Int) -> Bool
    checkTouching (r, c) (r1, c1)
      | r == r1 && c == c1 = True -- overlapping
      | r == r1 && (c == c1 + 1 || c == c1 - 1) = True -- horizontal
      | (r == r1 +1 || r == r1 - 1) && c == c1 = True -- vertical
      | (r == r1 + 1 || r == r1 - 1) && (c == c1 + 1 || c == c1 - 1) = True --diagonal
      | otherwise = False

    moveStep :: (Int, Int) -> String -> (Int, Int)
    moveStep (r, c) dir = case dir of
      "R" -> (r, c + 1)
      "L" -> (r, c - 1)
      "D" -> (r + 1, c)
      "U" -> (r - 1, c)

    follow :: (Int, Int) -> (Int, Int) -> (Int, Int)
    follow (hR, hC) (tR, tC)
      | checkTouching (hR, hC) (tR, tC) = (tR, tC)
      | hC == (tC + 2) && hR == tR = (tR, tC + 1) -- right
      | hC == (tC - 2) && hR == tR = (tR, tC - 1) -- left
      | hR == (tR + 2) && hC == tC = (tR +  1, tC) -- down
      | hR == (tR - 2) && hC == tC = (tR - 1, tC) -- up
      | (hR <= (tR - 2) && hC >= (tC + 1)) || (hR <= (tR - 1) && hC >= (tC + 2)) = (tR - 1, tC + 1) -- diag up right
      | (hR <= (tR - 2) && hC <= (tC - 1)) || (hR <= (tR - 1) && hC <= (tC - 2)) = (tR - 1, tC - 1) -- diag up left
      | (hR >= (tR + 2) && hC >= (tC + 1)) || (hR >= (tR + 1) && hC >= (tC + 2)) = (tR + 1, tC + 1) -- diag down right
      | (hR >= (tR + 2) && hC <= (tC - 1)) || (hR >= (tR + 1) && hC <= (tC - 2)) = (tR + 1, tC - 1) -- diag down left
      | otherwise = (tR, tC)

    move :: ([(Int, Int)], [(Int, Int)]) -> String -> Int -> ([(Int, Int)], [(Int, Int)])
    move (headPosition:headStack, tailPosition:tailStack) dir stepsCount
      | stepsCount == 0 = (headPosition:headStack, tailPosition:tailStack)
      | otherwise =
        let nextHeadPosition = moveStep headPosition dir
            nextTailPosition = follow nextHeadPosition tailPosition
        in move (nextHeadPosition:headPosition:headStack, nextTailPosition:tailPosition:tailStack) dir (stepsCount - 1)

    move2 :: ([(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)]) -> String -> Int -> ([(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)], [(Int, Int)])
    move2 (
      headPosition:headStack, 
      onePosition:oneStack, 
      twoPosition:twoStack, 
      treePosition:treeStack, 
      fourPosition:fourStack, 
      fivePosition:fiveStack, 
      sixPosition:sixStack, 
      sevenPosition:sevenStack, 
      eightPosition:eightStack,
      tailPosition:tailStack
      ) dir stepsCount
      | stepsCount == 0 = (headPosition:headStack, onePosition:oneStack, twoPosition:twoStack, treePosition:treeStack, fourPosition:fourStack, fivePosition:fiveStack, sixPosition:sixStack, sevenPosition:sevenStack, eightPosition:eightStack, tailPosition:tailStack)
      | otherwise =
        let nextHeadPosition = moveStep headPosition dir
            nextOnePosition = follow nextHeadPosition onePosition
            nextTwoPosition = follow nextOnePosition twoPosition
            nextTreePosition = follow nextTwoPosition treePosition
            nextFourPosition = follow nextTreePosition fourPosition
            nextFivePosition = follow nextFourPosition fivePosition
            nextSixPosition = follow nextFivePosition sixPosition
            nextSevenPosition = follow nextSixPosition sevenPosition
            nextEightPosition = follow nextSevenPosition eightPosition
            nextTailPosition = follow nextEightPosition tailPosition
        in move2 (
          nextHeadPosition:headPosition:headStack,
          nextOnePosition:onePosition:oneStack,
          nextTwoPosition:twoPosition:twoStack,
          nextTreePosition:treePosition:treeStack,
          nextFourPosition:fourPosition:fourStack,
          nextFivePosition:fivePosition:fiveStack,
          nextSixPosition:sixPosition:sixStack,
          nextSevenPosition:sevenPosition:sevenStack,
          nextEightPosition:eightPosition:eightStack,
          nextTailPosition:tailPosition:tailStack
          ) dir (stepsCount - 1)
