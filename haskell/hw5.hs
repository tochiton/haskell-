import Data.List 
import System.IO 


revIndex :: [Int] -> Int -> Int

revIndex aList index = aList !! (length aList - index - 1)  

reverseList :: [Int] -> [Int]
reverseList (x:xs) = reverseList xs ++ [x]



areListEq :: [Int] -> [Int] -> Bool
areListEq [][] = True
areListEq (x:xs) (y:xy) = x == y && areListEq xs xy
areListEq _ _ = False


wrapper :: [Int] -> Bool
wrapper input = areListEq input (reverse input)  