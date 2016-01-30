import Graphics.Element exposing (Element)
import ElmTest exposing (..)
import Rule30
import Array

tests : Test
tests =
  suite "Automaton Tests" [
        updateTests
    ]

updateTests : Test
updateTests =
  suite "Update Tests"
    [ test "modify in bounds" (Array.fromList [1,2,4] `assertEqual` Rule30.modify 2 (\x -> x + 1) (Array.fromList [1,2,3]))
    , test "modify out bounds" (Array.fromList [1,2,3] `assertEqual` Rule30.modify 4 (\x -> x + 1) (Array.fromList [1,2,3]))
    ]

main : Element
main =
  elementRunner tests
