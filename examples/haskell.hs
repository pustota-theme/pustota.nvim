{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE ScopedTypeVariables #-}

module SyntaxTest where

import Data.Maybe (fromMaybe)

--------------------------------------------------------------------------------
-- 1. Simple data type with record syntax
--------------------------------------------------------------------------------
data Person = Person
  { name :: String
  , age  :: Int
  } deriving (Show)

--------------------------------------------------------------------------------
-- 2. Sum type with multiple constructors
--------------------------------------------------------------------------------
data Color
  = Red
  | Green
  | Blue
  deriving (Show, Eq)

--------------------------------------------------------------------------------
-- 3. Newtype
--------------------------------------------------------------------------------
newtype MyInt = MyInt Int
  deriving (Eq, Ord, Show)

--------------------------------------------------------------------------------
-- 4. Type synonym
--------------------------------------------------------------------------------
type StringList = [String]

--------------------------------------------------------------------------------
-- 5. Pattern synonyms
--------------------------------------------------------------------------------
-- Matches the empty list
pattern EmptyList :: [a]
pattern EmptyList <- []
  where
    EmptyList = []

--------------------------------------------------------------------------------
-- 6. GADT
--------------------------------------------------------------------------------
data Expr a where
  IConst :: Int  -> Expr Int
  BConst :: Bool -> Expr Bool
  Add   :: Expr Int  -> Expr Int  -> Expr Int
  If    :: Expr Bool -> Expr a    -> Expr a   -> Expr a

--------------------------------------------------------------------------------
-- 7. Type families
--------------------------------------------------------------------------------
type family MyResult a where
  MyResult Int  = String
  MyResult Bool = Int
  MyResult a    = Maybe a

--------------------------------------------------------------------------------
-- 8. Multi-parameter type class
--------------------------------------------------------------------------------
class Convert a b where
  convert :: a -> b

--------------------------------------------------------------------------------
-- 9. Flexible instances
--------------------------------------------------------------------------------
instance Convert Int String where
  convert = show

instance Convert Bool Int where
  convert b = if b then 1 else 0

--------------------------------------------------------------------------------
-- 10. Function using type family results
--------------------------------------------------------------------------------
myResultExample :: MyResult Int -> MyResult Bool -> MyResult String
myResultExample s b =
  -- s is a String (MyResult Int)
  -- b is an Int    (MyResult Bool)
  -- so s ++ show b is also a String
  -- but MyResult String = Maybe String
  Just (s ++ show b)

--------------------------------------------------------------------------------
-- 11. Functions showing pattern matching, guards, and local bindings
--------------------------------------------------------------------------------
factorial :: (Eq a, Num a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

sign :: Int -> String
sign n
  | n < 0     = "Negative"
  | n == 0    = "Zero"
  | otherwise = "Positive"

greet :: String -> String
greet someName =
  let punctuation = "!"
  in "Hello, " ++ someName ++ punctuation

--------------------------------------------------------------------------------
-- 12. List comprehensions
--------------------------------------------------------------------------------
usageOfComprehension :: [Int]
usageOfComprehension = [ x * x | x <- [1..10], even x ]

--------------------------------------------------------------------------------
-- 13. Do notation (IO)
--------------------------------------------------------------------------------
usageOfDoMonad :: IO ()
usageOfDoMonad = do
  putStrLn "Enter a number: "
  line <- getLine
  let num = read line :: Int
  putStrLn $ "You entered: " ++ show num

--------------------------------------------------------------------------------
-- 14. Lambda case
--------------------------------------------------------------------------------
usageOfCaseLambda :: Int -> String
usageOfCaseLambda = \case
  0 -> "Zero"
  1 -> "One"
  _ -> "Many"

--------------------------------------------------------------------------------
-- 15. Pattern matching on records
--------------------------------------------------------------------------------
patternMatchingOnRecords :: Person -> String
patternMatchingOnRecords Person{name = n, age = a} =
  n ++ " is " ++ show a ++ " years old."

--------------------------------------------------------------------------------
-- 16. Main entry point (demonstrates various uses)
--------------------------------------------------------------------------------
main :: IO ()
main = do
  -- Basic function calls
  print (factorial 5)
  print (sign (-10))
  print (sign 0)
  print (sign 10)
  putStrLn (greet "World")

  -- List comprehension
  print usageOfComprehension

  -- IO do-notation
  usageOfDoMonad

  -- Lambda-case
  putStrLn $ usageOfCaseLambda 0
  putStrLn $ usageOfCaseLambda 42

  -- Record usage and updates
  let p1 = Person "Alice" 30
      p2 = p1 { age = 31 }  -- record update syntax
  putStrLn $ patternMatchingOnRecords p1
  putStrLn $ patternMatchingOnRecords p2

  -- Pattern synonyms
  case [] of
    EmptyList -> putStrLn "It’s an empty list!"
    _         -> putStrLn "Not empty."

  -- Multi-parameter type class usage
  let intVal  = (convert True  :: Int)
      strVal  = (convert 123   :: String)
  putStrLn $ "convert True  -> " ++ show intVal
  putStrLn $ "convert 123   -> " ++ strVal

  -- Type family usage
  let s  = "Answer: "             -- MyResult Int
      i  = 2                      -- MyResult Bool
      r  = myResultExample s i    -- MyResult String
  putStrLn $ "myResultExample: " ++ show r

  putStrLn "Done!"
