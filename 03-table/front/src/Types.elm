module Types exposing (Model, Msg(..), Post, Status(..), initialCmd, initialModel)

import Http
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (optional, required)

server : String
server =
    "http://localhost:3000/posts/"

---- MODEL ---

type Status
    = Failed
    | Loading
    | Loaded (List Post)

type alias Model =
    { status : Status
    , counter : Int
    }

initialModel : Model
initialModel =
    { status = Loading
    , counter = 0
    }

---- COMMAND ----

type alias Post =
    { id : Int
    , title : String
    , author : String
    , published : Bool
    }

type Msg
    = GotPosts (Result Http.Error (List Post))
    | Increase Int

postDecoder : Decoder Post
postDecoder =
    succeed Post
        |> required "id" int
        |> required "title" string
        |> required "author" string
        |> required "published" bool

initialCmd : Cmd Msg
initialCmd =
    Http.get
        { expect = Http.expectJson GotPosts (list postDecoder)
        , url = server
        }