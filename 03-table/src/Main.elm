module Main exposing (..)

import Browser
import Types exposing (Model(..), Msg(..), initialCmd, initialModel)
import View exposing (view)



---- MODEL ----


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, initialCmd )



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotPosts (Err httpError) ->
            ( Failed, Cmd.none )

        GotPosts (Ok posts) ->
            ( Loaded posts, Cmd.none )



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- PROGRAM ----


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
