module Rule30 where

import Html exposing (div, button, text)
import StartApp.Simple as StartApp
import Array exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Color

main : Signal Html.Html
main =
  StartApp.start { model = model, view = view, update = update }

type alias Row = Array Bool
type alias Grid = Array Row

model : Grid
model =
  let size = 30
      row = Array.repeat size False
  in Array.repeat size row

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

toggle : Bool -> Bool
toggle = not

on : Bool -> Bool
on _ = True

off : Bool -> Bool
off _ = False

modify : Int -> (a -> a) -> Array a -> Array a
modify index f array =
  let current = Array.get index array
      new = Maybe.map f current
      setter = Maybe.map (Array.set index) new
  in Maybe.withDefault identity setter array

updateCell : Int -> Int -> (Bool -> Bool) -> Grid -> Grid
updateCell coli rowi action grid =
  let rowAction = modify coli action
  in modify rowi rowAction grid

update : a -> Grid -> Grid
update action model =
  model
