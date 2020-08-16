module PhotoGroove exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Browser

baseUrl : String
baseUrl = "http://elm-in-action.com/"

thumbnail : String -> String -> Html { data : String, description : String }
thumbnail selected thumb = 
    img 
        [ src (baseUrl ++ thumb) 
        , classList [ ("selected", selected == thumb )]
        , onClick { description = "ClickedPhoto", data = thumb }
        ] 
        []

update msg model =
    if msg.description == "ClickedPhoto" then
        { model | selected = msg.data }
    else
        model

view model =
    div [ class "content"]
        [ h1 [] [ text "Photo Groove" ]
        , div [ id "thumbnails" ] 
            (List.map 
                (thumbnail model.selected)
                model.photos
            )
        , img 
            [ class "large"
            , src (baseUrl ++ "large/" ++ model.selected)
            ]
            []
        ]

initialModel = 
    {
        photos = [
            "1.jpeg"
            , "2.jpeg"
            , "3.jpeg"
        ]
        , selected = "1.jpeg"
    }

main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }