module Graphics.Update exposing (init, setViewport, setCursor)

{-| Model manipulating functions for the graphics view.
-}

import Graphics.Model exposing (Model, Cursor(..))
import Graphics.Internal.Settings as Settings
import Graphics.Internal.TerrainPager as TerrainPager
import Graphics.Internal.Terrain as Terrain
import Math.Matrix4 as Mat4 exposing (Mat4)
import Window exposing (Size)


{-| Initialize the model.
-}
init : Size -> Model
init viewport =
    { viewport = viewport
    , aspectRatio = getAspectRatio viewport
    , projectionMatrix = makeProjectionMatrix <| getAspectRatio viewport
    , cursor = Default
    , terrainMesh = Terrain.makeMesh
    , terrainPager = TerrainPager.init
    }


{-| Set a new viewport.
-}
setViewport : Size -> Model -> Model
setViewport viewport model =
    { model
        | viewport = viewport
        , aspectRatio = getAspectRatio viewport
        , projectionMatrix = makeProjectionMatrix <| getAspectRatio viewport
    }


{-| Set the cursor type.
-}
setCursor : Cursor -> Model -> Model
setCursor cursor model =
    { model | cursor = cursor }


{-| Calculate the projection matrix for an aspect ratio.
-}
makeProjectionMatrix : Float -> Mat4
makeProjectionMatrix aspectRatio =
    Mat4.makePerspective Settings.fov
        aspectRatio
        Settings.near
        Settings.far


getAspectRatio : Size -> Float
getAspectRatio viewport =
    toFloat viewport.width / toFloat viewport.height
