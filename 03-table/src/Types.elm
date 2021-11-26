module Types exposing (Model(..), Msg(..), Post, initialCmd, initialModel)

import Http
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (optional, required)



---- MODEL ----


type alias Post =
    { id : Int
    , title : String
    , author : String
    }


postDecoder : Decoder Post
postDecoder =
    succeed Post
        |> required "id" int
        |> required "title" string
        |> required "author" string


type Model
    = Failed
    | Loading
    | Loaded (List Post)


initialModel : Model
initialModel =
    Loading



---- MSG ----


type Msg
    = GotPosts (Result Http.Error (List Post))



---- CMD ----


server : String
server =
    "http://localhost:3000/posts/"


initialCmd : Cmd Msg
initialCmd =
    Http.get
        { expect = Http.expectJson GotPosts (list postDecoder)
        , url = server
        }
