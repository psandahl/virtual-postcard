module Graphics.Update
    exposing
        ( init
        , setViewport
        , setCursor
        , pageTiles
        )

{-| Model manipulating functions for the graphics view.
-}

import Camera.Model as Camera
import Graphics.Model exposing (Model, Cursor(..))
import Settings
import Graphics.Internal.SkyDome as SkyDome
import Graphics.Internal.TerrainPager as TerrainPager
import Graphics.Internal.Terrain as Terrain
import Graphics.Internal.WaterSurface as WaterSurface
import Math.Matrix4 as Mat4 exposing (Mat4)
import Window exposing (Size)


{-| Initialize the model.
-}
init : Size -> Camera.Model -> Model
init viewport camera =
    { viewport = viewport
    , aspectRatio = getAspectRatio viewport
    , projectionMatrix = makeProjectionMatrix <| getAspectRatio viewport
    , cursor = Default
    , skyDomeMesh = SkyDome.makeMesh
    , terrainMesh = Terrain.makeMesh
    , waterMesh = WaterSurface.makeMesh
    , terrainPager = TerrainPager.init (getAspectRatio viewport) camera
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


{-| Page tiles for the given camera.
-}
pageTiles : Camera.Model -> Model -> Model
pageTiles camera model =
    { model | terrainPager = TerrainPager.selectFromCamera (getAspectRatio model.viewport) camera model.terrainPager }


{-| Calculate the projection matrix for an aspect ratio.
-}
makeProjectionMatrix : Float -> Mat4
makeProjectionMatrix aspectRatio =
    Mat4.makePerspective Settings.fov
        aspectRatio
        Settings.nearPlane
        Settings.farPlane


getAspectRatio : Size -> Float
getAspectRatio viewport =
    toFloat viewport.width / toFloat viewport.height
