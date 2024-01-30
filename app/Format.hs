{-# LANGUAGE NamedFieldPuns #-}

module Format (showTable) where

import Data.List.Extra (groupSortOn, sortOn)
import Data.Maybe (fromMaybe)
import Data.Ord (Down (..))
import Text.Printf (PrintfType, printf)

import Types (Grade (..))

rowFormat :: String
rowFormat = "║ %-10.10s ║ %-50.50s ║ %-10.10s ║ %-10.10s ║ %-10.10s ║ %-10.10s ║ %-10.10s ║"

headerFormat :: String
headerFormat = "╔%-12.12s╦%-52.52s╦%-12.12s╦%-12.12s╦%-12.12s╦%-12.12s╦%-12.12s╗"

footerFormat :: String
footerFormat = "╚%-12.12s╩%-52.52s╩%-12.12s╩%-12.12s╩%-12.12s╩%-12.12s╩%-12.12s╝"

separatorFormat :: String
separatorFormat = "╠%-12.12s╬%-52.52s╬%-12.12s╬%-12.12s╬%-12.12s╬%-12.12s╬%-12.12s╣"

format :: (PrintfType t) => String -> t
format f = printf f k k k k k k k
  where
    k = cycle "═"

formatRow :: Grade -> String
formatRow
    Grade
        { prüfNr
        , prüfungstext
        , semester
        , note
        , status
        , ects
        , versuch
        } = printf rowFormat (show prüfNr) prüfungstext (show semester) (maybe "" show note) status (show ects) (show versuch)

showTable :: [Grade] -> String
showTable gs =
    unlines $
        [ format headerFormat
        , printf
            rowFormat
            ("PrüfNr." :: String)
            ("Prüfungstext" :: String)
            ("Semester" :: String)
            ("Note" :: String)
            ("Status" :: String)
            ("ECTS" :: String)
            ("Versuch" :: String)
        , format separatorFormat
        ]
            ++ init
                ( concatMap
                    ( (++ [format separatorFormat])
                        . map formatRow
                        . sortOn (fromMaybe (read "Infinity") . note)
                    )
                    . groupSortOn (Down . semester)
                    $ gs
                )
            ++ [ format
                    footerFormat
               ]
