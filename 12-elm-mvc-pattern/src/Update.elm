module Update exposing (update)

import Model exposing (Model, Post)
import Msg exposing (Msg(..))

update : Msg -> Model -> Model
update msg model =
    case msg of
        AddPost ->
            let
                newPost = { id = model.nextId, title = model.form.title, content = model.form.content }
            in
            { model
                | posts = newPost :: model.posts
                , nextId = model.nextId + 1
                , form = { id = 0, title = "", content = "" }
            }

        DeletePost id ->
            { model | posts = List.filter (\post -> post.id /= id) model.posts }

        EditPost id ->
            let
                post = List.head (List.filter (\x -> x.id == id) model.posts)
            in
            case post of
                Just p ->
                    { model | form = p }
                Nothing ->
                    model

        UpdateTitle title ->
            { model | form = { title = title, content = model.form.content, id = model.form.id } }

        UpdateContent content ->
            { model | form = { title = model.form.title, content = content, id = model.form.id } }

        SavePost ->
            let
                updatedPosts = List.map (\post -> if post.id == model.form.id then model.form else post) model.posts
            in
            { model | posts = updatedPosts, form = { id = 0, title = "", content = "" } }
