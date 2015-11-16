module MusicClient where

import Html
import Effects exposing (Never)
import StartApp
import Task

import Album


type alias App =
  { html : Signal Html.Html
  , model : Signal Album.Model
  , tasks : Signal (Task.Task Never ())
  }


app : App
app =
  StartApp.start
    { init = Album.init 2
    , update = Album.update
    , view = Album.view
    , inputs = []
    }


main : Signal Html.Html
main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
