module Main exposing (..)

--------------------------------------------------------------------------------
-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--
--------------------------------------------------------------------------------

import Browser
import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)



--------------------------------------------------------------------------------
-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



--------------------------------------------------------------------------------
-- MODEL


type alias Model =
    Int


init : Model
init =
    0



--------------------------------------------------------------------------------
-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



--------------------------------------------------------------------------------
-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "Hello World!" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Decrement ] [ text "-" ]
        , button [ onClick Increment ] [ text "+" ]
        ]
