module Button where

-- いつものやつモジュール
import Prelude

-- 値が入っていないのを許容するモジュール
import Data.Maybe (Maybe(..))
-- halogenの基本モジュール
import Halogen as H
-- halogenのHTML要素モジュール
import Halogen.HTML as HH
-- halogenのEvent系を取り扱うモジュール
import Halogen.HTML.Events as HE
-- helogenのプロパティを表現するモジュール
import Halogen.HTML.Properties as HP


-- ボタンの状態を表す
type State = Boolean

-- クエリ代数
-- Queryとは、type: -> type:で、常に型変数を持っている
data Query a
  -- アクションのコンストラクタ
  = Toggle a
　--   リクエストのコンストラクタ
  | IsOn (Boolean -> a)

-- 親コンポーネントがあった場合に使うが、今回使わないのでUnitを使用する
type Input = Unit

-- コンポーネントに必要な出力メッセージを定義する。
-- 今回はボタン切替と状態を返す
data Message = Toggled Boolean

myButton :: forall m. H.Component HH.HTML Query Input Message m
myButton =
  H.component
    { initialState: const initialState
    , render
    , eval
    , receiver: const Nothing
    }
  where

  initialState :: State
  initialState = false

  render :: State -> H.ComponentHTML Query
  render state =
    let
      label = if state then "On" else "Off"
    in
        HH.div_
            [ HH.text "Hello PureScript トグルボタン"
            ,HH.div_
                [HH.button
                    [ HP.title label
                    , HE.onClick (HE.input_ Toggle)
                    ]
                    [ HH.text label ]
                ]
            ]

  eval :: Query ~> H.ComponentDSL State Query Message m
  eval = case _ of
    Toggle next -> do
      state <- H.get
      let nextState = not state
      H.put nextState
      H.raise $ Toggled nextState
      pure next
    IsOn reply -> do
      state <- H.get
      pure (reply state)
