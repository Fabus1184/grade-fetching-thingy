module Main (main) where

import Format (showTable)
import System.Environment (lookupEnv)
import Web (fetch)

main :: IO ()
main = do
    user <- lookupEnv "USERNAME" >>= maybe (error "USERNAME not set") pure
    pw <- lookupEnv "PASSWORD" >>= maybe (error "PASSWORD not set") pure

    fetch user pw >>= either (error . show) pure >>= putStrLn . showTable
