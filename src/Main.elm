module Main exposing (..)

--import Gridview as Gridview exposing (..)

import Html as H exposing (..)
import Dict as Dict exposing (..)
import Image exposing (Image)
import Material.Card as Card
import Material.Options as Options exposing (cs, css)
import Material.Color as Color
import Image.Collection as Collection exposing (Collection)
import String.Interpolate exposing (interpolate)


main : Program Never Model Msg
main =
    H.program { view = view, update = update, subscriptions = subscriptions, init = init }


view : Model -> Html Msg
view model =
    div []
        (List.map
            cardview
            (toList
                model.imagecollection
            )
        )


type Msg
    = ChangeUrl String
    | AddImage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeUrl url ->
            { model | imageUrl = url } ! []

        AddImage ->
            let
                url =
                    model.imageUrl
            in
                { model
                    | imagecollection =
                        Dict.insert url (Image url 320 320) model.imagecollection
                }
                    ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


white : Options.Property c m
white =
    Color.text Color.white


type alias Model =
    { imagecollection : Collection
    , imageUrl : String
    }


init : ( Model, Cmd Msg )
init =
    ( { imagecollection =
            Dict.fromList
                [ ( "1", Image "/images/resources/tissue_paithani_saree.jpg" 240 320 )
                , ( "2", Image "/images/resources/traditional_paithani_saree.jpg" 240 320 )
                ]
      , imageUrl = "/images/resources/tissue_paithani_saree.jpg"
      }
    , Cmd.none
    )


output : String -> String
output testparam =
    interpolate "url({0}) center / cover" [ testparam ]


cardview : ( a1, { c | url : b } ) -> Html a
cardview imagename =
    Card.view
        [ css "width" "256px"
        ]
        [ Card.title
            [ css "background" (output (toString (Tuple.second imagename).url))
            , css "height" "330px"
            , css "padding" "0"
            ]
            [ Card.head
                [ css "width" "100%"
                ]
                [ text "" ]
            ]
        , Card.text []
            [ text "Non-alcoholic syrup used for both its tart and sweet flavour as well as its deep red color." ]
        , Card.actions
            [ Card.border ]
            []
        ]
