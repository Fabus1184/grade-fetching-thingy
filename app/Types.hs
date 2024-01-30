{-# LANGUAGE InstanceSigs #-}

module Types (Grade (..), Semester (..)) where

data Grade = Grade
    { prüfNr :: Int
    , prüfungstext :: String
    , semester :: Semester
    , note :: Maybe Double
    , status :: String
    , ects :: Double
    , versuch :: Int
    }
    deriving (Show, Eq, Ord)

data Semester = WS Int Int | SS Int deriving (Eq)

instance Show Semester where
    show :: Semester -> String
    show (SS a) = "SS " <> show a
    show (WS a b) = "WS " <> show a <> "/" <> show b

instance Ord Semester where
    compare :: Semester -> Semester -> Ordering
    compare (SS a) (SS b) = compare a b
    compare (WS a b) (WS c d) = compare (a, b) (c, d)
    compare (SS a) (WS b c) = compare (a, 0) (b, c)
    compare (WS a b) (SS c) = compare (a, b) (c, 0)
