module Main exposing (..)

import Browser
import Types exposing (Model, Msg(..), Status(..), initialCmd, initialModel)
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
            let
                _ =
                    Debug.log "Error" msg
            in
            ( { model
                | status = Failed
              }
            , Cmd.none
            )

        GotPosts (Ok posts) ->
            let
                _ =
                    Debug.log "Ok" msg
            in
            ( { model
                | status = Loaded posts
              }
            , Cmd.none
            )

        Increase num ->
            let
                _ =
                    Debug.log "Button Clicked" model.counter
            in
            ( { model | counter = model.counter + num }, Cmd.none )

        Checked num ->
            let
                _ =
                    Debug.log "Checked " 1
            in
            ( model, Cmd.none )

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
