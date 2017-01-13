module Main where

import Control.Monad.Trans.Cont
import Text.Printf

mkString :: Cont String String
mkString = printf "%d-%d-%d" <$> mkInt 0 <*> mkInt 1 <*> mkInt 2

mkInt :: Int -> Cont String Int
mkInt x = round <$> mkDouble (fromIntegral x)

mkDouble :: Double -> Cont String Double
mkDouble 1 = cont $ \cc -> head
                         $ filter (== "0-3-3")
                         $ map cc [0,0.1..]
mkDouble x = return $ 1.5 * x

main :: IO ()
main = print (evalCont mkString)
