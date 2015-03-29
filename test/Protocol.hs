{-|
Module      : Protocol
Description : Test for Network.Kademlia.Protocol

Tests specific to Network.Kademlia.Protocol.
-}

module Protocol
    ( parseCheck
    , lengthCheck
    , IdType(..)
    ) where

import Test.QuickCheck
import qualified Test.QuickCheck.Property as P

import qualified Data.ByteString as B
import Network.Kademlia.Types
import Network.Kademlia.Protocol
import TestTypes

-- | A signal is the same as its serialized form parsed
parseCheck :: Signal IdType String -> P.Result
parseCheck s = test . parse (peer . source $ s) . serialize id . command $ s
    where id = (nodeId . source $ s)
          test (Left err) = P.failed { P.reason = "Parsing failed: " ++ err }
          test (Right s') = P.result {
                  P.ok = Just (s == s')
                , P.reason = "Signals differ:\nIn:  " ++ show s ++ "\nOut: "
                             ++ show s' ++ "\n"
            }

-- | A serialized signal's length is no longer than the max. UDP packet size
--   (or at least what I believe to be the max UDP packet size)
lengthCheck :: Signal IdType String -> P.Result
lengthCheck s = P.result { P.ok = Just $ length <= 1500, P.reason = reason }
    where length = B.length . serialize (nodeId . source $ s) . command $ s
          reason = "Serialized signal is too long: " ++ show length ++ " bytes"
