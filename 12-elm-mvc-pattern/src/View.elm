module View exposing (view)

import Html exposing (Html, button, div, h1, input, li, text, ul)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import Model exposing (Model, Post)
import Msg exposing (Msg(..))

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Posts" ]
        , input [ placeholder "Title", value model.form.title, onInput UpdateTitle ] []
        , input [ placeholder "Content", value model.form.content, onInput UpdateContent ] []
        , button [ onClick AddPost ] [ text "Add Post" ]
        , ul [] (List.map viewPost model.posts)
        ]

viewPost : Post -> Html Msg
viewPost post =
    li []
        [ text (post.title ++ ": " ++ post.content)
        , button [ onClick (DeletePost post.id) ] [ text "Delete" ]
        , button [ onClick (EditPost post.id) ] [ text "Edit" ]
        ]
