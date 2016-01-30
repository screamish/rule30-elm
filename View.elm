module View where

import Html exposing (div, button, text)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Color
import Array
import Rule30 exposing (..)

darkGrey : Color.Color
darkGrey = Color.rgba 111 111 111 0.8

lightGrey : Color.Color
lightGrey = Color.rgba 111 111 111 0.2

viewSquare : Bool -> Element
viewSquare s =
  let shape = square 20 |> filled (if s then darkGrey else lightGrey)
  in collage 20 20 [shape]

viewRow : Row -> Element
viewRow row =
  row
  |> Array.map viewSquare
  |> Array.toList
  |> flow right

viewGrid : Grid -> Element
viewGrid g =
  g
  |> Array.map viewRow
  |> Array.toList
  |> flow down

view : Signal.Address a -> Grid -> Html.Html
view address model =
  div []
        [ Html.text "BEHOLD!"
        , div [] [ viewGrid model |> Html.fromElement ]
        ]
