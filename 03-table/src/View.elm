module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, classList, id, name, src, title, type_)
import Types exposing (Model(..), Msg(..), Post)


view : Model -> Html Msg
view model =
    case model of
        Failed ->
            viewFailed

        Loading ->
            viewLoading

        Loaded posts ->
            viewLoaded posts


viewFailed : Html Msg
viewFailed =
    div
        []
        [ text "I was unable to load your book." ]


viewLoading : Html Msg
viewLoading =
    div
        []
        [ text "Loading..." ]


viewLoaded : List Post -> Html Msg
viewLoaded posts =
    div []
        [ viewTable posts ]


viewTable : List Post -> Html Msg
viewTable posts =
    table
        []
        [ viewTableHeader
        , viewTableBody posts
        ]


viewTableHeader : Html Msg
viewTableHeader =
    thead
        []
        [ tr
            []
            [ th []
                [ text "ID" ]
            , th []
                [ text "Title" ]
            , th []
                [ text "Author" ]
            ]
        ]


viewTableBody : List Post -> Html Msg
viewTableBody posts =
    tbody
        []
        (List.map viewTableData posts)


viewTableData : Post -> Html Msg
viewTableData post =
    tr []
        [ td []
            [ text <| String.fromInt post.id ]
        , td []
            [ text post.title ]
        , td []
            [ text post.author ]
        ]
