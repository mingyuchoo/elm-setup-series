module PhotoGroove3 exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, classList, id, name, src, title, type_)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (optional, required)
import Random


urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"



---- MODEL ----


type Size
    = Small
    | Medium
    | Large


type alias URL =
    String


type alias Photo =
    { url : String
    , size : Int
    , title : String
    }

type Msg
    = ClickedPhoto String
    | ClickedSize Size
    | ClickedSurpriseMe
    | GotRandomPhoto Photo
    | GotPhotos (Result Http.Error (List Photo))

photoDecoder : Decoder Photo
photoDecoder =
    succeed Photo
        |> required "url" string
        |> required "size" int
        |> optional "title" string "(untitled)"


initialCmd : Cmd Msg
initialCmd =
    Http.get
        { url = "http://elm-in-action.com/photos/list.json"
        , expect = Http.expectJson GotPhotos (list photoDecoder)
        }


type Status
    = Loading
    | Loaded (List Photo) String
    | Errored String


selectUrl : URL -> Status -> Status
selectUrl url status =
    case status of
        Loaded photos _ ->
            Loaded photos url

        Loading ->
            status

        Errored errorMessage ->
            status


type alias Model =
    { status : Status
    , chosenSize : Size
    }


initialModel : Model
initialModel =
    { status = Loading
    , chosenSize = Medium
    }



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotRandomPhoto photo ->
            ( { model | status = selectUrl photo.url model.status }, Cmd.none )

        ClickedPhoto url ->
            ( { model | status = selectUrl url model.status }, Cmd.none )

        ClickedSize size ->
            ( { model | chosenSize = size }, Cmd.none )

        ClickedSurpriseMe ->
            case model.status of
                Loading ->
                    ( model, Cmd.none )

                Loaded [] _ ->
                    ( model, Cmd.none )

                Loaded (firstPhoto :: otherPhotos) _ ->
                    Random.uniform firstPhoto otherPhotos
                        |> Random.generate GotRandomPhoto
                        |> Tuple.pair model

                Errored errorMessage ->
                    ( model, Cmd.none )

        GotPhotos (Ok photos) ->
            case photos of
                [] ->
                    ( { model | status = Errored "O photos found" }, Cmd.none )

                first :: rest ->
                    ( { model | status = Loaded photos first.url }, Cmd.none )

        GotPhotos (Err httpError) ->
            ( { model | status = Errored "Server error!" }, Cmd.none )



---- INIT ----


init : flags -> ( Model, Cmd Msg )
init flags =
    ( initialModel, initialCmd )



---- VIEW ----


view : Model -> Html Msg
view model =
    div
        [ class "content" ]
        (case model.status of
            Loading ->
                []

            Loaded photos url ->
                viewLoaded photos url model.chosenSize

            Errored errorMessage ->
                [ text ("Error: " ++ errorMessage) ]
        )


viewLoaded : List Photo -> URL -> Size -> List (Html Msg)
viewLoaded photos url chosenSize =
    [ h1
        []
        [ text "Photo Groove" ]
    , button
        [ onClick ClickedSurpriseMe ]
        [ text "Surprise Me!" ]
    , h3
        []
        [ text "Thumbnail Size:" ]
    , div
        [ id "choose-size" ]
        (List.map viewSizeChooser [ Small, Medium, Large ])
    , div
        [ id "thumbnails"
        , class (sizeToString chosenSize)
        ]
        (List.map (viewThumbnail url) photos)
    , img
        [ class "large"
        , src (urlPrefix ++ "large/" ++ url)
        ]
        []
    ]


viewThumbnail : URL -> Photo -> Html Msg
viewThumbnail url thumb =
    img
        [ src (urlPrefix ++ thumb.url)
        , title (thumb.title ++ " [" ++ String.fromInt thumb.size ++ " KB]")
        , classList [ ( "selected", url == thumb.url ) ]
        , onClick (ClickedPhoto thumb.url)
        ]
        []


viewSizeChooser : Size -> Html Msg
viewSizeChooser size =
    label
        []
        [ input
            [ type_ "radio"
            , name "size"
            , onClick (ClickedSize size)
            ]
            []
        , text (sizeToString size)
        ]


sizeToString : Size -> String
sizeToString size =
    case size of
        Small ->
            "small"

        Medium ->
            "med"

        Large ->
            "large"



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
