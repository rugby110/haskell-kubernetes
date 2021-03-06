-- Copyright (c) 2016-present, SoundCloud Ltd.
-- All rights reserved.
--
-- This source code is distributed under the terms of a MIT license,
-- found in the LICENSE file.

{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}

module Kubernetes.Model.V1.FCVolumeSource
    ( FCVolumeSource (..)
    , targetWWNs
    , lun
    , fsType
    , readOnly
    , mkFCVolumeSource
    ) where

import           Control.Lens.TH           (makeLenses)
import           Data.Aeson.TH             (defaultOptions, deriveJSON,
                                            fieldLabelModifier)
import           Data.Text                 (Text)
import           GHC.Generics              (Generic)
import           Prelude                   hiding (drop, error, max, min)
import qualified Prelude                   as P
import           Test.QuickCheck           (Arbitrary, arbitrary)
import           Test.QuickCheck.Instances ()

-- | Represents a Fibre Channel volume. Fibre Channel volumes can only be mounted as read/write once. Fibre Channel volumes support ownership management and SELinux relabeling.
data FCVolumeSource = FCVolumeSource
    { _targetWWNs :: !([Text])
    , _lun        :: !(Integer)
    , _fsType     :: !(Text)
    , _readOnly   :: !(Maybe Bool)
    } deriving (Show, Eq, Generic)

makeLenses ''FCVolumeSource

$(deriveJSON defaultOptions{fieldLabelModifier = (\n -> if n == "_type_" then "type" else P.drop 1 n)} ''FCVolumeSource)

instance Arbitrary FCVolumeSource where
    arbitrary = FCVolumeSource <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

-- | Use this method to build a FCVolumeSource
mkFCVolumeSource :: [Text] -> Integer -> Text -> FCVolumeSource
mkFCVolumeSource xtargetWWNsx xlunx xfsTypex = FCVolumeSource xtargetWWNsx xlunx xfsTypex Nothing
