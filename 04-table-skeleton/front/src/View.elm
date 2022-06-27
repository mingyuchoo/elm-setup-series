module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (checked, class, classList, id, name, src, title, type_)
import Html.Events exposing (onClick)
import Types exposing (Model, Msg(..), Post, Status(..))


view : Model -> Html Msg
view model =
    div []
        [ viewButton
        , viewCounter model.counter
        , case model.status of
            Failed -> viewFailed
            Loading -> viewLoading
            Loaded posts -> viewLoaded posts
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
        [ viewTableLoading ]


viewTableLoading : Html Msg
viewTableLoading =
    table []
          [ viewTableHeader
          , viewTableBodyLoading
          ]


viewTableBodyLoading : Html Msg
viewTableBodyLoading =
    tbody []
        (List.repeat 3 viewTableDataLoading)


viewTableDataLoading : Html Msg
viewTableDataLoading =
    tr []
       [ td [] [ div [ class "skeleton", class "skeleton-text" ] [] ]
       , td [] [ div [ class "skeleton", class "skeleton-text" ] [] ]
       , td [] [ div [ class "skeleton", class "skeleton-text" ] [] ]
       , td [] [ div [ class "skeleton", class "skeleton-text" ] [] ]
       ]


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
       , td [] [ input [ type_ "checkbox" , checked post.published ] [] ]
       ]
