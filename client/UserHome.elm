module Page.UserHome where

import Color exposing (..)
import Graphics.Element exposing (..)
import Markdown
import Text
import Window
import Debug

import ColorScheme as C
import Component.TopMenuBar as TopMenu


port title : String
port title = "Music app"

type alias TileSize = (Int, Int)

small : TileSize
small =
  (200, 200)

tall : TileSize
tall =
  (200, 400)

wide : TileSize
wide =
  (400, 200)

large : TileSize
large =
  (400, 420)


main : Signal Element
main =
    Signal.map view Window.dimensions


view : (Int,Int) -> Element
view (windowWidth, windowHeight) =
  color C.background <|
  flow down
  [ TopMenu.view windowWidth
  , spacer windowWidth 20
  , flow right
      [ spacer 20 20
      , flow down
        [ tile small C.mediumGrey "Group"
        , spacer 200 20
        , tile small C.mediumGrey "Latest Comment"
        ]
      , spacer 20 200
      , tile large lightBlue "Album of the Week"
      ]
  , color C.mediumGrey (spacer windowWidth 1)
  , spacer windowWidth 20
  , flow right
    [ dynamicSpacer windowWidth windowHeight
    , tile small blue "woop"
    , spacer 80 10
    , tile wide gray "weep"
    ]
  , spacer windowWidth 100
  ]


tile : TileSize -> Color -> String -> Element
tile tileSize tileColor label =
  color tileColor <|
        container (fst tileSize) (snd tileSize) middle (centered (Text.fromString label))

dynamicSpacer : Int -> Int -> Element
dynamicSpacer totalWidth totalHeight =
  let
    d3 = Debug.watch "height" height == height
    d2 = Debug.watch "width" width == width
    d1 = Debug.watch "totalHeight" totalHeight == totalHeight
    d = Debug.watch "totalWidth" totalWidth == totalWidth
    width = ((totalWidth - 980) // 2)
    height = (totalHeight - TopMenu.height - 260 - 20 - 1)
  in
    spacer width height

button : String -> String -> Element
button href txt =
  leftAligned (Text.color white (Text.fromString txt))
    |> container 158 38 middle
    |> color C.blue
    |> container 160 40 middle
    |> color (rgb 5 80 129)
    |> link href
    |> container 200 80 middle


left1 : Element
left1 = Markdown.toElement """
# Install Packages
Use [`elm-package`][elm-package] to install community packages:
[elm-package]: https://github.com/elm-lang/elm-package
```
elm-package install user/project
```
[`elm-package`][elm-package] is sandboxed by default. All packages are
installed on a per-project basis, so all your projects dependencies are
independent.
<br>
# Reliable Versioning
Thanks to Elm&rsquo;s design, `elm-package` is able to automatically enforce
versioning rules based on API changes. You can always compare APIs by running
a command like:
```
elm-package diff evancz/elm-html 1.0.0 1.1.0
```
This will show you all the values that were added, removed, and changed between
version 1.0.0 and 1.1.0. Based on these API diffs, `elm-package` enforces [a
restricted form of semver 2.0.0][rules], so PATCH changes really are PATCH
changes in Elm.
[rules]: https://github.com/elm-lang/elm-package#version-rules
"""

right1 : Element
right1 = Markdown.toElement """
# Design Guidelines
Before publishing packages with [`elm-package`][elm-package], look through the
[API Design Guidelines][design]. Some key takeaways are:
 * Design for a concrete use case
 * Use human readable names
 * Avoid gratuitous abstraction
 * [Write nice documentation][docs]
After looking through [the guidelines][design] carefully and [writing helpful
documentation][docs], publish your library with:
```
elm-package publish
```
For more information on publishing with `elm-package` check out
[the comprehensive usage overview](https://github.com/elm-lang/elm-package/blob/master/README.md).
[elm-package]: https://github.com/elm-lang/elm-package
[design]: /help/design-guidelines
[docs]: /help/documentation-format
"""
