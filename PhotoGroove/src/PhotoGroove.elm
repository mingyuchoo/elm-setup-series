module PhotoGroove exposing (..)

import Array exposing (Array)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random



---- MODEL ----


type alias URL =
    String


type alias Photo =
    { url : URL
    }


type PhotoSize
    = Small
    | Medium
    | Large


type alias Model =
    { photos : List Photo
    , selectedUrl : URL
    , chosenSize : PhotoSize
    }


initialModel : Model
initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedUrl = "1.jpeg"
    , chosenSize = Medium
    }


init : flags -> ( Model, Cmd Msg )
init flags =
    ( initialModel, Cmd.none )



---- UPDATE ----


type Msg
    = ClickedSize PhotoSize
    | ClickedPhoto String
    | ClickedSurpriseMe
    | GotSelectedIndex Int


photoArray : Array Photo
photoArray =
    Array.fromList initialModel.photos


getPhotoUrl : Int -> String
getPhotoUrl index =
    case Array.get index photoArray of
        Just photo ->
            photo.url

        Nothing ->
            ""


randomPhotoPicker : Random.Generator Int
randomPhotoPicker =
    Random.int 0 (Array.length photoArray - 1)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedSize size ->
            ( { model | chosenSize = size }, Cmd.none )

        ClickedPhoto url ->
            ( { model | selectedUrl = url }, Cmd.none )

        ClickedSurpriseMe ->
            ( model, Random.generate GotSelectedIndex randomPhotoPicker )

        GotSelectedIndex index ->
            ( { model | selectedUrl = getPhotoUrl index }, Cmd.none )



---- VIEW ----


urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"


viewThumbnail : String -> Photo -> Html Msg
viewThumbnail selectedUrl photo =
    img
        [ classList [ ( "selected", selectedUrl == photo.url ) ]
        , src <| urlPrefix ++ photo.url
        , onClick <| ClickedPhoto photo.url
        ]
        []


viewLarge : Model -> Html Msg
viewLarge model =
    img
        [ class "large"
        , src <| urlPrefix ++ "large/" ++ model.selectedUrl
        ]
        []


isChecked : PhotoSize -> Model -> Bool
isChecked size model =
    if size == model.chosenSize then
        True

    else
        False


sizeToString : PhotoSize -> String
sizeToString size =
    case size of
        Small ->
            "small"

        Medium ->
            "med"

        Large ->
            "large"


viewSizeChooser : PhotoSize -> Model -> Html Msg
viewSizeChooser size model =
    label
        []
        [ input
            [ type_ "radio"
            , name "size"
            , onClick <| ClickedSize size
            , checked <| isChecked size model
            ]
            []
        , text <| sizeToString size
        ]


view : Model -> Html Msg
view model =
    div
        [ class "content" ]
        [ h1
            []
            [ text "Thumb Groove" ]
        , button
            [ onClick ClickedSurpriseMe ]
            [ text "Surprise Me!" ]
        , h3
            []
            [ text "Thumbnail Size: " ]
        , div
            [ id "choose-size" ]
            (List.map2 viewSizeChooser [ Small, Medium, Large ] <| List.repeat 3 model)
        , div
            [ id "thumbnails"
            , class <| sizeToString model.chosenSize
            ]
            (List.map (viewThumbnail model.selectedUrl) model.photos)
        , viewLarge model
        ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }
