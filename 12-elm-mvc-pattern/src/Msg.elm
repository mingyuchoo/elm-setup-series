module Msg exposing (Msg(..))

import Model exposing (Post)

type Msg
    = AddPost
    | DeletePost Int
    | EditPost Int
    | UpdateTitle String
    | UpdateContent String
    | SavePost
