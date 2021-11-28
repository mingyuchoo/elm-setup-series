module Types exposing (Model, Msg(..), Post, Status(..), initialCmd, initialModel)

import Http
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (optional, required)



---- MODEL ----


type alias Post =
    { id : Int
    , title : String
    , author : String
    , published : Bool
    }


postDecoder : Decoder Post
postDecoder =
    succeed Post
        |> required "id" int
        |> required "title" string
        |> required "author" string
        |> required "published" bool


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



---- MSG ----


type Msg
    = GotPosts (Result Http.Error (List Post))
    | Increase Int
    | Checked Int



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
