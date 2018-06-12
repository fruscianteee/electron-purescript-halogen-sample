module Main where

-- 基本コマンドモジュール
import Prelude
import Effect (Effect)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Button as B

main :: Effect Unit
-- 非同期処理のHalogenを実行する
main = HA.runHalogenAff do
  -- DOMが読み込まれるのを待ってから、Body要素を取得してセット
  body <- HA.awaitBody
  -- bodyに対して、ボタン要素をマウント
  runUI B.myButton unit body
