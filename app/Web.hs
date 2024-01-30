{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module Web (fetch) where

import Control.Lens (view, (.~), (?~), (^.))
import Control.Monad (void, when)
import Control.Monad.IO.Class (MonadIO (liftIO))
import Control.Monad.Trans.Except (runExceptT, throwE)
import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString.Lazy.Char8 as BSL
import Data.Char (isPrint)
import Data.Function ((&))
import Data.List.Extra (replace, trim)
import Data.Maybe (mapMaybe)
import qualified Data.Text as T
import Data.Text.Encoding (decodeUtf8)
import Network.Wreq (FormParam (..), checkResponse, defaults)
import Network.Wreq.Lens (param, responseBody)
import Network.Wreq.Session (get, newSession, postWith)
import Text.HTML.TagSoup (Attribute, Tag (..), innerText, parseTags)
import Text.Read (readMaybe)

import Types (Grade (..), Semester (..))

url :: String
url = "https://www.verwaltung.hs-ulm.de/studieren/rds?state=user&type=0&category=auth.logout"

fetch :: String -> String -> IO (Either String [Grade])
fetch user pw = runExceptT $ do
    session <- liftIO newSession
    void . liftIO $ get session url

    response <-
        liftIO
            ( postWith
                ( defaults
                    & checkResponse ?~ (\_ _ -> pure ())
                    & param "state" .~ ["user"]
                    & param "type" .~ ["1"]
                    & param "category" .~ ["auth.login"]
                    & param "startpage" .~ ["portal.vm"]
                    & param "breadCrumbSource" .~ ["portal"]
                )
                session
                url
                [ (:=) @String "asdf" user
                , (:=) @String "fdsa" pw
                , (:=) @String "submit" "Ok"
                ]
            )

    let body = response ^. responseBody

    when ("Anmeldung fehlgeschlagen" `BS.isInfixOf` BSL.toStrict body) $
        throwE "Login failed"

    let links = filterTag "a" $ parseTags body
    link <-
        filter
            ( \case
                (_, [TagText t]) -> "Notenübersicht" `BS.isInfixOf` BSL.toStrict t
                _ -> False
            )
            links
            & \case
                (_ : ("href", x) : _, _) : _ -> pure (BSL.unpack x)
                _ -> throwE "Notenübersicht not found"

    html <-
        parseTags
            . BS.pack
            . T.unpack
            . decodeUtf8
            . BSL.toStrict
            . view responseBody
            <$> liftIO (get session link)

    pure $ mapMaybe parseTableRow $ filterTag "tr" html

filterTag :: (Eq t) => t -> [Tag t] -> [([Attribute t], [Tag t])]
filterTag _ [] = []
filterTag tag (TagOpen tag' attrs : rest)
    | tag == tag' = (attrs, x) : filterTag tag y
  where
    (x, y) = break (== TagClose tag') rest
filterTag tag (_ : rest) = filterTag tag rest

parseTableRow :: ([Attribute BS.ByteString], [Tag BS.ByteString]) -> Maybe Grade
parseTableRow ([("bgcolor", "#EFEFEF")], ts)
    | length ts == 33 =
        let ts' = map (fmap (trim . filter isPrint . BS.unpack)) ts
         in Just $
                Grade
                    (read @Int $ innerText [ts' !! 2])
                    (innerText [ts' !! 6])
                    (parseSemester $ innerText [ts' !! 10])
                    (readMaybe @Double . replace "," "." . innerText $ [ts' !! 14])
                    (innerText [ts' !! 18])
                    (read @Double . innerText $ [ts' !! 22])
                    (read @Int . innerText $ [ts' !! 30])
parseTableRow _ = Nothing

parseSemester :: String -> Semester
parseSemester ['S', 'S', ' ', a, b] = SS $ read [a, b]
parseSemester ['W', 'S', ' ', a, b, '/', c, d] = WS (read [a, b]) (read [c, d])
parseSemester s = error $ "Invalid semester: " <> show s
