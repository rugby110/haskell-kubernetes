-- Copyright (c) 2016-present, SoundCloud Ltd.
-- All rights reserved.
--
-- This source code is distributed under the terms of a MIT license,
-- found in the LICENSE file.

{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}

module Kubernetes.Model.V1.ConfigMapList
    ( ConfigMapList (..)
    , kind
    , apiVersion
    , metadata
    , items
    , mkConfigMapList
    ) where

import           Control.Lens.TH                       (makeLenses)
import           Data.Aeson.TH                         (defaultOptions,
                                                        deriveJSON,
                                                        fieldLabelModifier)
import           Data.Text                             (Text)
import           GHC.Generics                          (Generic)
import           Kubernetes.Model.Unversioned.ListMeta (ListMeta)
import           Kubernetes.Model.V1.ConfigMap         (ConfigMap)
import           Prelude                               hiding (drop, error, max,
                                                        min)
import qualified Prelude                               as P
import           Test.QuickCheck                       (Arbitrary, arbitrary)
import           Test.QuickCheck.Instances             ()

-- | ConfigMapList is a resource containing a list of ConfigMap objects.
data ConfigMapList = ConfigMapList
    { _kind       :: !(Maybe Text)
    , _apiVersion :: !(Maybe Text)
    , _metadata   :: !(Maybe ListMeta)
    , _items      :: !(Maybe [ConfigMap])
    } deriving (Show, Eq, Generic)

makeLenses ''ConfigMapList

$(deriveJSON defaultOptions{fieldLabelModifier = (\n -> if n == "_type_" then "type" else P.drop 1 n)} ''ConfigMapList)

instance Arbitrary ConfigMapList where
    arbitrary = ConfigMapList <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

-- | Use this method to build a ConfigMapList
mkConfigMapList :: ConfigMapList
mkConfigMapList = ConfigMapList Nothing Nothing Nothing Nothing
