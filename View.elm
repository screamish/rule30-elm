module View where

import Html exposing (div, button, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Array
import Rule30 exposing (..)

viewSquare : Bool -> Html.Html
viewSquare on =
    div [if on then style [("backgroundColor", "black"), ("width", "20px"), ("height", "20px")]
                  else style [("backgroundColor", "grey"), ("width", "20px"), ("height", "20px")]] []

viewRow : Array.Array Bool -> List Html.Html
viewRow row =
  row
  |> Array.map viewSquare
  |> Array.toList

view : Signal.Address () -> Row -> Html.Html
view address model =
  div []
        [ Html.text "BEHOLD!"
        , div [style [("display", "flex")]]  (viewRow model)
        , div [] [ button [ onClick address () ][ Html.text "Next!" ]]
        ]
