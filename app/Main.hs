module Main (main) where

import Data.List.Extra (groupSortOn, maximumOn)
import Data.Ord (Down (..))
import SimplePrompt (prompt, promptPassword)

import Format (showTable)
import Types (Grade (..))
import Web (fetch)

main :: IO ()
main = do
    user <- prompt "Enter Username"
    pw <- promptPassword "Enter Password"

    fetch user pw
        >>= either (error . show) pure
        >>= putStrLn
            . showTable
            . map fixEntries
            . Data.List.Extra.groupSortOn (Down . semester)

-- for whatever reason, many entries appear twice, once with a zero appended to the Prüf.Nr
fixEntries :: [Grade] -> [Grade]
fixEntries = map (maximumOn versuch) . groupSortOn (f . prüfNr)
  where
    f x = if x `mod` 10 == 0 then x `div` 10 else x
