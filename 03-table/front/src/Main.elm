module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (checked, class, classList, id, name, src, title, type_)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (optional, required)



---- MAIN ----


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



---- MSG ----


type Msg
    = GotPosts (Result Http.Error (List Post))
    | Increase Int



---- MODEL ----


type alias Model =
    { status : Status
    , counter : Int
    }


type Status
    = Failed
    | Loading
    | Loaded (List Post)


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, initialCmd )


initialModel : Model
initialModel =
    { status = Loading
    , counter = 0
    }



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



---- CMD ----


type alias Post =
    { id : Int
    , title : String
    , author : String
    , published : Bool
    }


initialCmd : Cmd Msg
initialCmd =
    Http.get
        { expect = Http.expectJson GotPosts (list postDecoder)
        , url = "http://localhost:3000/posts/"
        }


postDecoder : Decoder Post
postDecoder =
    succeed Post
        |> required "id" int
        |> required "title" string
        |> required "author" string
        |> required "published" bool



---- SUB ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ viewButton
        , viewCounter model.counter
        , case model.status of
            Failed ->
                viewFailed

            Loading ->
                viewLoading

            Loaded posts ->
                viewLoaded posts
        ]


viewButton : Html Msg
viewButton =
    div []
        [ button [ onClick (Increase 1) ] [ text "Click!" ]
        ]


viewCounter : Int -> Html Msg
viewCounter counter =
    div []
        [ p [] [ text (String.fromInt counter) ]
        ]


viewFailed : Html Msg
viewFailed =
    div []
        [ text "I was unable to load your book." ]


viewLoading : Html Msg
viewLoading =
    div []
        [ text "Loading..." ]


viewLoaded : List Post -> Html Msg
viewLoaded posts =
    div []
        [ viewTable posts ]


viewTable : List Post -> Html Msg
viewTable posts =
    table []
        [ viewTableHeader
        , viewTableBody posts
        ]


viewTableHeader : Html Msg
viewTableHeader =
    thead []
        [ tr []
            [ th [] [ text "ID" ]
            , th [] [ text "Title" ]
            , th [] [ text "Author" ]
            , th [] [ text "Published" ]
            ]
        ]


viewTableBody : List Post -> Html Msg
viewTableBody posts =
    tbody []
        (List.map viewTableData posts)


viewTableData : Post -> Html Msg
viewTableData post =
    tr []
        [ td [] [ text <| String.fromInt post.id ]
        , td [] [ text post.title ]
        , td [] [ text post.author ]
        , td [] [ input [ type_ "checkbox", checked post.published ] [] ]
        ]
