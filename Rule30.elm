module Rule30 where

import Array exposing (..)

type alias Row = Array Bool
type alias Grid = Array Row

size : Int
size = 31

emptyRow : Row
emptyRow = Array.repeat size False

emptyGrid : Grid
emptyGrid = Array.repeat size emptyRow

initialState1 : Row
initialState1 =
  let midpoint = Array.length emptyRow |> (\x -> x // 2)
  in emptyRow |> modify midpoint on

model : Row
model = initialState1

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

modify' : Int -> (Int -> Array a -> a) -> Array a -> Array a
modify' index f array =
  let new = f index array
  in Array.set index new array

updateCellInGrid : Int -> Int -> (Bool -> Bool) -> Grid -> Grid
updateCellInGrid coli rowi action grid =
  let rowAction = modify rowi action
  in modify coli rowAction grid

newValForCellInRow : ((Bool, Bool, Bool) -> Bool) -> Int -> Row -> Bool
newValForCellInRow action rowi row =
  let get' i arr = Array.get (rowi + i) arr |> Maybe.withDefault False
      values arr = (get' (-1) arr, get' 0 arr, get' 1 arr)
  in action (values row)

updateRow : ((Bool, Bool, Bool) -> Bool) -> Row -> Row
updateRow rules row =
  let mapf : Int -> Bool -> Bool
      mapf i _ = newValForCellInRow rules i row
  in Array.indexedMap mapf row

update : a -> Row -> Row
update action model =
  model |> updateRow rules

rules : (Bool, Bool, Bool) -> Bool
rules (l,c,r) =
  case (l,c,r) of
    (True, True, True) -> False
    (True, True, False) -> False
    (True, False, True) -> False
    (True, False, False) -> True
    (False, True, True) -> True
    (False, True, False) -> True
    (False, False, True) -> True
    (False, False, False) -> False

    -- current pattern	111	110	101	100	011	010	001	000
    -- new state for center cell	0	0	0	1	1	1	1	0
