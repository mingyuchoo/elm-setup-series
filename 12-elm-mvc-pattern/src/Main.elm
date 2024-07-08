module Main exposing (main)

import Browser
import Html exposing (Html)
import Model exposing (Model, initModel)
import Update exposing (update)
import View exposing (view)
import Msg exposing (Msg(..))

main =
    Browser.sandbox { init = initModel, update = update, view = view }
