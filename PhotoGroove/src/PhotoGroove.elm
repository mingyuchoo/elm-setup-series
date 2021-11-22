module PhotoGroove exposing (..)

import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (..)



---- MODEL ----
type alias URL = String

type alias Thumb =
    { url : URL
    }

type alias Model =
    { photos : List Thumb
    , selectedUrl : URL
    }


initialModel : Model
initialModel =
    { photos = 
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ] 
    , selectedUrl = "1.jpeg"
    }



---- VIEW ----

urlPrefix : String
urlPrefix = 
    "http://elm-in-action.com/"

viewThumbnail : String -> Thumb -> Html msg
viewThumbnail selectedUrl thumb =
    img
        [ src <| urlPrefix ++ thumb.url
        , classList [ ( "selected" , selectedUrl == thumb.url) ]
        ]
        []


view :  Model -> Html msg
view model =
    div
        [ class "content" ]
        [ h1
            []
            [ text "Thumb Groove" ]
        , div
            [ id "thumbnails" ]
            ( List.map 
                (\photo -> viewThumbnail model.selectedUrl photo)
                model.photos
            )
        , img
            [ class "large"
            , src <| urlPrefix ++ "large/" ++ model.selectedUrl
            ]
            []
        ]



---- PROGRAM ----


main : Html msg
main =
    view initialModel
