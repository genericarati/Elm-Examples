module Gridview exposing (..)

import Array
import Material.Grid as Grid exposing (..)
import Material.Options as Options exposing (Style, css)
import Material.Color as Color
import Image.Collection as Collection exposing (Collection)
import Image exposing (Image)
import Html as H exposing (..)
import Dict as Dict exposing (..)


type alias Model =
    { imagecollection : Collection
    , imageUrl : String
    }


type Msg
    = ChangeUrl String
    | AddImage


style : Int -> List (Style a)
style h =
    [ css "text-sizing" "border-box"
    , css "background-color" "#BDBDBD"
    , css "height" (toString h ++ "px")
    , css "padding-left" "8px"
    , css "padding-top" "4px"
    , css "color" "white"
    ]


democell : Int -> List (Style a) -> List (Html a) -> Cell a
democell k styling =
    cell <| List.concat [ style k, styling ]


small : List (Style a) -> List (Html a) -> Cell a
small =
    democell 500


color : Int -> Style a
color k =
    Array.get ((k + 0) % Array.length Color.hues) Color.hues
        |> Maybe.withDefault Color.Teal
        |> flip Color.color Color.S500
        |> Color.background


init : ( Model, Cmd Msg )
init =
    ( { imagecollection =
            Dict.fromList
                [ ( "1", Image "/images/resources/tissue_paithani_saree.jpg" 240 320 )
                , ( "2", Image "/images/resources/tissue_paithani_saree.jpg" 240 320 )
                ]
      , imageUrl = "/images/resources/tissue_paithani_saree.jpg"
      }
    , Cmd.none
    )


gridview : Model -> Html Msg
gridview model =
    List.range 1 1
        |> List.map
            (\i ->
                small [ Grid.size All 6, color 2 ]
                    [ Collection.view [] Collection.defaultItemViewer model.imagecollection
                    ]
            )
        |> grid []
