module Main where

import StartApp.Simple as StartApp
import Rule30 exposing (model, update)
import View exposing (view)
import Html

main : Signal Html.Html
main =
  StartApp.start { model = model, view = view, update = update }
