module Rule30 where

import Array exposing (..)

type alias Row = Array Bool
type alias Grid = Array Row

emptyGrid : Grid
emptyGrid =
  let size = 31
      row = Array.repeat size False
  in Array.repeat size row

model : Grid
model = emptyGrid |> updateCell 0 15 on

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
  let rowAction = modify rowi action
  in modify coli rowAction grid

update : a -> Grid -> Grid
update action model =
  model
