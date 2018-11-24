{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Data.Aeson (FromJSON, ToJSON)
import Data.Text (Text)
import GHC.Generics (Generic)
import Network.Wai (Application)
import Servant
import Servant.Server

import qualified Network.Wai.Handler.Warp

data Request = Request {  }
    deriving (Generic, FromJSON)

data Response = Response {  }
    deriving (Generic, ToJSON)

type WebHook =
    Header "X-GitHub-Event" Text
    :> ReqBody '[JSON] Request
    :> Post '[JSON] ()

server :: Server WebHook
server (Just "pull_request") request = return ()
server _ _ = fail "Oops!"

application :: Application
application = serve (Proxy :: Proxy WebHook) server

main :: IO ()
main = Network.Wai.Handler.Warp.run 8080 application
