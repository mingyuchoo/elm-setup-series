module Model exposing (Model, Post, initModel)

type alias Post =
    { id : Int
    , title : String
    , content : String
    }

type alias Model =
    { posts : List Post
    , nextId : Int
    , form : Post
    }

initModel : Model
initModel =
    { posts = []
    , nextId = 1
    , form = { id = 0, title = "", content = "" }
    }
