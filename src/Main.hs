{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Control.Monad.IO.Class (liftIO)
import Data.Aeson (FromJSON, ToJSON)
import Data.Text (Text)
import GHC.Generics (Generic)
import Network.Wai (Application)
import Servant
import Servant.Server

import qualified Network.Wai.Handler.Warp
import qualified Network.Wai.Middleware.RequestLogger as RequestLogger

data Request = Request { pull_request :: PullRequest }
    deriving (Generic, FromJSON, Show)

data PullRequest = PullRequest { number :: Integer }
    deriving (Generic, FromJSON, Show)

data Response = Response {  }
    deriving (Generic, ToJSON)

type WebHook =
    Header "X-GitHub-Event" Text
    :> ReqBody '[JSON] Request
    :> Post '[JSON] ()

-- server :: Maybe Text -> Request -> Handler ()
server :: Server WebHook
server (Just "pull_request") request = liftIO $ print request
server _ _ = fail "Oops!"

application :: Application
application = RequestLogger.logStdoutDev $ serve @WebHook Proxy server

main :: IO ()
main = Network.Wai.Handler.Warp.run 8080 application
