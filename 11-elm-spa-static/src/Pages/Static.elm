module Pages.Static exposing (page)

import Gen.Params.Static exposing (Params)
import Html
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI
import View exposing (View)


page : Shared.Model -> Request -> Page
page shared req =
    Page.static
        { view = view
        }


view : View msg
view =
    { title = "Static"
    , body = UI.layout [ Html.text "Static" ]
    }
