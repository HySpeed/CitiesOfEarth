-- config.lua
-- Jun 2018
-- Configuration Options

GAME_MODE_MSG = "Choose a city area to be in:"



---------------------------------------
-- Resource & Spawn Circle Options
---------------------------------------

CHUNK_SIZE = 32
ENFORCE_LAND_AREA_TILE_DIST = CHUNK_SIZE * 3
CHART_AREA = 200

-- Location of water strip (horizontal)
WATER_SPAWN_OFFSET_X =  -4
WATER_SPAWN_OFFSET_Y = -38
WATER_SPAWN_LENGTH   =   8

-- Start resource amounts (per tile/oil spot)
START_COAL_AMOUNT    = 1500
START_IRON_AMOUNT    = 1500
START_TREE_AMOUNT    = 1000
START_STONE_AMOUNT   = 1000
START_COPPER_AMOUNT  = 1500
START_URANIUM_AMOUNT = 1000
START_OIL_AMOUNT     = 300000

-- Start resource shape
-- If this is true, it will be a circle
-- If false, it will be a square
ENABLE_RESOURCE_SHAPE_CIRCLE = true

-- Start resource position and size
-- Position is relative to player starting location
START_RESOURCE_STONE_POS_X = -27
START_RESOURCE_STONE_POS_Y = -34
START_RESOURCE_STONE_SIZE  =  12

START_RESOURCE_URANIUM_POS_X =  17
START_RESOURCE_URANIUM_POS_Y = -34
START_RESOURCE_URANIUM_SIZE  =  10

START_RESOURCE_COAL_POS_X = -27
START_RESOURCE_COAL_POS_Y = -20
START_RESOURCE_COAL_SIZE  =  12

START_RESOURCE_IRON_POS_X =  17
START_RESOURCE_IRON_POS_Y = -10
START_RESOURCE_IRON_SIZE  =  16

START_RESOURCE_COPPER_POS_X = -28
START_RESOURCE_COPPER_POS_Y =  -3
START_RESOURCE_COPPER_SIZE  =  14

START_RESOURCE_TREE_POS_X = -10
START_RESOURCE_TREE_POS_Y = -20
START_RESOURCE_TREE_SIZE  =  20


-- Specify oil quantity & locations for starting oil.
START_RESOURCE_OIL_NUM_PATCHES = 4
-- The first patch
START_RESOURCE_OIL_POS_X =  5
START_RESOURCE_OIL_POS_Y = 20
-- How far each patch is offset from the others and in which direction
-- Default (x=0, y=-4) means that patches spawn in a vertical row downwards.
START_RESOURCE_OIL_X_OFFSET = -4
START_RESOURCE_OIL_Y_OFFSET =  0

