{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Lens           ((&), (.~), (<&>), (?~))
import Data.Text              (Text)
import Network.Google
-- import Network.Google.Storage
import Network.Google.BigQuery
import System.IO              (stdout)

import qualified Data.Text as Text

example :: IO ProjectList
example = do
    lgr  <- newLogger Debug stdout
    env  <- newEnv <&> (envLogger .~ lgr) . (envScopes .~ bigQueryScope)

    runResourceT . runGoogle env $ send projectsList

{-
example :: IO Object
example = do
    lgr  <- newLogger Debug stdout -- (1)
    env  <- newEnv <&> (envLogger .~ lgr) . (envScopes .~ storageReadWriteScope) -- (2) (3)
    body <- sourceBody "/path/to/image.jpg" -- (4)

    let key = "image.jpg"
        bkt = "my-storage-bucket"

    runResourceT . runGoogle env $ -- (5)
        upload (objectsInsert bkt object' & oiName ?~ key) body
-}

main :: IO ()
main = do
  putStrLn "hello world"
