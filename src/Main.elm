module Main exposing (..)

import Html as H exposing (..)
import Dict as Dict exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Image.Collection as Collection exposing (Collection)
import Image exposing (Image)


main : Program Never Model Msg
main =
    H.program { view = view, update = update, subscriptions = subscriptions, init = init }


type alias Model =
    { imagecollection : Collection
    , imageUrl : String
    }


type Msg
    = ChangeUrl String
    | AddImage


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


view : Model -> Html Msg
view model =
    div []
        [ urlForm
        , Collection.view [] Collection.defaultItemViewer model.imagecollection
        ]


urlForm : Html Msg
urlForm =
    H.div []
        [ H.input
            [ HA.type_ "text"
            , HA.placeholder "Image url"
            , HE.onInput ChangeUrl
            ]
            []
        , H.input
            [ HA.type_ "submit"
            , HA.value "Add Image"
            , HE.onClick AddImage
            ]
            []
        ]


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
