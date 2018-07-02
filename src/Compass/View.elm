module Compass.View exposing (view)

{-| Rendering of compass.
-}

import Compass.Model exposing (Model)
import Composer.Model exposing (Msg)
import Html exposing (Html)
import Html.Attributes as Attr
import Svg
import Svg.Attributes as SAttr


{-| Render the compass.
-}
view : Model -> Html Msg
view model =
    Html.div
        [ Attr.style
            [ ( "position", "absolute" )
            , ( "right", "10px" )
            , ( "top", "10px" )
            , ( "transform", "rotate(" ++ toString model.angle ++ "deg)" )
            ]
        ]
        [ Svg.svg
            [ SAttr.width "100"
            , SAttr.height "100"
            ]
            [ Svg.circle
                [ SAttr.cx "50"
                , SAttr.cy "50"
                , SAttr.r "45"
                , SAttr.stroke "black"
                , SAttr.strokeWidth "1"
                , SAttr.fillOpacity "0.0"
                ]
                []
            , Svg.polygon
                [ SAttr.points "50,5 45,50 55,50"
                , SAttr.fill "red"
                , SAttr.fillOpacity "1.0"
                ]
                []
            , Svg.polygon
                [ SAttr.points "50,95 45,50 55,50"
                , SAttr.fill "white"
                , SAttr.fillOpacity "1.0"
                ]
                []
            ]
        ]