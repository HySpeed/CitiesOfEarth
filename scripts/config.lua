-- config.lua
-- Jun 2018
-- Configuration Options

---------------------------------------
-- Resource & Spawn Circle Options
---------------------------------------

CHUNK_SIZE = 32
ENFORCE_LAND_AREA_TILE_DIST = CHUNK_SIZE * 4
CHART_AREA = 200
SPAWN_WOBBLE = 4 -- a small amount of variance for teleport

-- Start resource amounts (per tile/oil spot)
START_COAL_AMOUNT    = 1500
START_IRON_AMOUNT    = 1500
START_TREE_AMOUNT    = 1000
START_STONE_AMOUNT   = 1000
START_COPPER_AMOUNT  = 1500
START_URANIUM_AMOUNT = 1000
START_OIL_AMOUNT     = 300000

-- If false, it will be a square
ENABLE_RESOURCE_SHAPE_CIRCLE = true

-- Position is relative to provided location
-- Location of water strip (horizontal)
WATER_SPAWN_OFFSET_X =  -4
WATER_SPAWN_OFFSET_Y = -30
WATER_SPAWN_LENGTH   =   8

START_RESOURCE_STONE_POS_X = -27
START_RESOURCE_STONE_POS_Y = -30
START_RESOURCE_STONE_SIZE  =  12

START_RESOURCE_URANIUM_POS_X =  17
START_RESOURCE_URANIUM_POS_Y = -30
START_RESOURCE_URANIUM_SIZE  =  10

START_RESOURCE_COAL_POS_X = -27
START_RESOURCE_COAL_POS_Y = -15
START_RESOURCE_COAL_SIZE  =  12

START_RESOURCE_IRON_POS_X =  12
START_RESOURCE_IRON_POS_Y =  -5
START_RESOURCE_IRON_SIZE  =  16

START_RESOURCE_COPPER_POS_X = -28
START_RESOURCE_COPPER_POS_Y =   5
START_RESOURCE_COPPER_SIZE  =  14

START_RESOURCE_TREE_POS_X =  -5
START_RESOURCE_TREE_POS_Y = -20
START_RESOURCE_TREE_SIZE  =  15

-- Specify oil quantity & locations for starting oil.
START_RESOURCE_OIL_NUM_PATCHES = 4
-- The first patch
START_RESOURCE_OIL_POS_X =  5
START_RESOURCE_OIL_POS_Y = 20
-- How far each patch is offset from the others and in which direction
-- Default (x=0, y=-4) means that patches spawn in a vertical row downwards.
START_RESOURCE_OIL_X_OFFSET = -4
START_RESOURCE_OIL_Y_OFFSET =  0

---------------------------------------
-- Safe Spawn Area Options
---------------------------------------

-- Safe area has no aliens
SAFE_AREA_SIZE = CHUNK_SIZE * 7

-- Warning area has reduced aliens
WARN_AREA_SIZE = CHUNK_SIZE * 10

-- 1 : X (spawners alive : spawners destroyed) in this area
WARN_AREA_REDUCTION_RATIO = 10
