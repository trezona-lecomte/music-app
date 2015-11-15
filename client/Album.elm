module Album where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Graphics.Element exposing (show)
import String exposing (concat)
import Effects exposing (Effects)
import Json.Decode as Json
import Http
import Task


-- MODEL

type alias Model =
  { id : Int
  , name : String
  }

init : Int -> (Model, Effects Action)
init id =
  ( Model id "Retrieving album..."
  , getAlbum id
  )


-- UPDATE

type Action
  = RequestAlbum
  | ReceiveAlbum (Maybe String)

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    RequestAlbum ->
      ( model
      , getAlbum model.id
      )

    ReceiveAlbum maybeName ->
      ( Model model.id (Maybe.withDefault model.name maybeName)
      , Effects.none
      )


-- EFFECTS

getAlbum : Int -> Effects Action
getAlbum id =
  Http.get decodeAlbumName (albumUrl id)
    |> Task.toMaybe
    |> Task.map ReceiveAlbum
    |> Effects.task

albumUrl : Int -> String
albumUrl id =
  Http.url (concat ["http://localhost:3000/albums/", toString id])
    [ ]

decodeAlbumName : Json.Decoder String
decodeAlbumName =
  Json.at ["data", "attributes", "name"] Json.string


-- VIEW

(=>) = (,)

view : Signal.Address Action -> Model -> Html
view address model =
  div [ style [ "width" => "200px" ] ]
      [ h2 [ headerStyle ] [ text model.name ]
      , div [ ] [ text (toString model.id) ]
      , button [ onClick address RequestAlbum ] [ text "Find album" ]
      ]

headerStyle : Attribute
headerStyle =
  style
    [ "width" => "200px"
    , "text-align" => "center"
    ]
