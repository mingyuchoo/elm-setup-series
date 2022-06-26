module Pages.Home_ exposing (view)

import UI
import Html
import View exposing (View)


view : View msg
view =
    { title = "Homepage"
    , body = UI.layout [ Html.text "Hello, world!" ]
    }

