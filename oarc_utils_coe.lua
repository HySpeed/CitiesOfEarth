-- oarc_utils.lua
-- Nov 2016 / June 2018
-- 
-- general purpose utility functions for factorio
-- Also contains some constants 


--------------------------------------------------------------------------------
-- Useful constants
--------------------------------------------------------------------------------
CHUNK_SIZE = 32
MAX_FORCES = 64
TICKS_PER_SECOND = 60
TICKS_PER_MINUTE = TICKS_PER_SECOND * 60
TICKS_PER_HOUR = TICKS_PER_MINUTE * 60
--------------------------------------------------------------------------------

GAME_SURFACE_NAME="Game"

--------------------------------------------------------------------------------
-- General Helper Functions
--------------------------------------------------------------------------------


-- Prints flying text.
-- Color is optional
function FlyingText(msg, pos, color, surface)
    if color == nil then
        surface.create_entity({ name = "flying-text", position = pos, text = msg })
    else
        surface.create_entity({ name = "flying-text", position = pos, text = msg, color = color })
    end
end

-- Create area given point and radius-distance
function GetAreaFromPointAndDistance(point, dist)
    local area = {left_top=
                    {x=point.x-dist,
                     y=point.y-dist},
                  right_bottom=
                    {x=point.x+dist,
                     y=point.y+dist}}
    return area
end

-- Check if given position is in area bounding box
function CheckIfInArea(point, area)
    if ((point.x >= area.left_top.x) and (point.x < area.right_bottom.x)) then
        if ((point.y >= area.left_top.y) and (point.y < area.right_bottom.y)) then
            return true
        end
    end
    return false
end


-- Get a random 1 or -1
function RandomNegPos()
    if (math.random(0,1) == 1) then
        return 1
    else
        return -1
    end
end

-- Create a random direction vector to look in
function GetRandomVector()
    local randVec = {x=0,y=0}   
    while ((randVec.x == 0) and (randVec.y == 0)) do
        randVec.x = math.random(-3,3)
        randVec.y = math.random(-3,3)
    end
    DebugPrint("direction: x=" .. randVec.x .. ", y=" .. randVec.y)
    return randVec
end

-- Get an area given a position and distance.
-- Square length = 2x distance
function GetAreaAroundPos(pos, dist)
    return {left_top=      {x=pos.x-dist,
                            y=pos.y-dist},
            right_bottom = {x=pos.x+dist,
                            y=pos.y+dist}}
end

--------------------------------------------------------------------------------
-- Resource patch and starting area generation
--------------------------------------------------------------------------------

-- Generate the basic starter resource around a given location.
function GenerateStartingResources(surface, city)
  local cityArea = {{city.x-CHUNK_SIZE, city.y-CHUNK_SIZE}, {city.x+CHUNK_SIZE, city.y+CHUNK_SIZE}}
   
  -- Remove trees/resources inside the spawn area
  RemoveInCircle(surface, cityArea, "tree", city, ENFORCE_LAND_AREA_TILE_DIST)
  RemoveInCircle(surface, cityArea, "resource", city, ENFORCE_LAND_AREA_TILE_DIST+5)
  RemoveInCircle(surface, cityArea, "cliff", city, ENFORCE_LAND_AREA_TILE_DIST+5)
  RemoveDecorationsArea(surface, cityArea)

   
  CreateWaterStrip(surface, {x=city.x+WATER_SPAWN_OFFSET_X, y=city.y+WATER_SPAWN_OFFSET_Y  }, WATER_SPAWN_LENGTH)
  CreateWaterStrip(surface, {x=city.x+WATER_SPAWN_OFFSET_X, y=city.y+WATER_SPAWN_OFFSET_Y+1}, WATER_SPAWN_LENGTH)

  -- Generate oil patches
  oil_patch_x=city.x+START_RESOURCE_OIL_POS_X
  oil_patch_y=city.y+START_RESOURCE_OIL_POS_Y
  for i=1,START_RESOURCE_OIL_NUM_PATCHES do
      surface.create_entity({name="crude-oil", amount=START_OIL_AMOUNT, position={oil_patch_x, oil_patch_y}})
      oil_patch_x=oil_patch_x+START_RESOURCE_OIL_X_OFFSET
      oil_patch_y=oil_patch_y+START_RESOURCE_OIL_Y_OFFSET
  end

  -- Generate stone
  local stonePos = {x=city.x+START_RESOURCE_STONE_POS_X, y=city.y+START_RESOURCE_STONE_POS_Y}
  GenerateResourcePatch(surface, "stone", START_RESOURCE_STONE_SIZE, stonePos, START_STONE_AMOUNT)

  -- Generate coal
  local coalPos = {x=city.x+START_RESOURCE_COAL_POS_X, y=city.y+START_RESOURCE_COAL_POS_Y}
  GenerateResourcePatch(surface, "coal", START_RESOURCE_COAL_SIZE, coalPos, START_COAL_AMOUNT)

  -- Generate copper ore
  local copperOrePos = {x=city.x+START_RESOURCE_COPPER_POS_X, y=city.y+START_RESOURCE_COPPER_POS_Y}
  GenerateResourcePatch(surface, "copper-ore", START_RESOURCE_COPPER_SIZE, copperOrePos, START_COPPER_AMOUNT)

  -- Generate iron ore
  local ironOrePos = {x=city.x+START_RESOURCE_IRON_POS_X, y=city.y+START_RESOURCE_IRON_POS_Y}
  GenerateResourcePatch(surface, "iron-ore", START_RESOURCE_IRON_SIZE, ironOrePos, START_IRON_AMOUNT)

  -- Generate uranium
  local uraniumOrePos = {x=city.x+START_RESOURCE_URANIUM_POS_X, y=city.y+START_RESOURCE_URANIUM_POS_Y}
  GenerateResourcePatch(surface, "uranium-ore", START_RESOURCE_URANIUM_SIZE, uraniumOrePos, START_URANIUM_AMOUNT)

  -- Tree generation is needed
  local treePos = {x=city.x+START_RESOURCE_TREE_POS_X, y=city.y+START_RESOURCE_TREE_POS_Y}
  GenerateResourcePatch(surface, "tree-02", START_RESOURCE_TREE_SIZE, treePos, START_TREE_AMOUNT)

end

-- Create a horizontal line of water
function CreateWaterStrip(surface, leftPos, length)
    local waterTiles = {}
    for i=0,length,1 do
        table.insert(waterTiles, {name = "water", position={leftPos.x+i,leftPos.y}})
    end
    surface.set_tiles(waterTiles)
end 

-- Function to generate a resource patch, of a certain size/amount at a pos.
function GenerateResourcePatch(surface, resourceName, diameter, pos, amount)
    local midPoint = math.floor(diameter/2)
    if (diameter == 0) then
        return
    end
    for y=0, diameter do
        for x=0, diameter do
            if (not ENABLE_RESOURCE_SHAPE_CIRCLE or ((x-midPoint)^2 + (y-midPoint)^2 < midPoint^2)) then
                surface.create_entity({name=resourceName, amount=amount, position={pos.x+x, pos.y+y}})
            end
        end
    end
end

-- Removes the entity type from the area given
-- Only if it is within given distance from given position.
function RemoveInCircle(surface, area, type, pos, dist)
    for key, entity in pairs(surface.find_entities_filtered({area=area, type= type})) do
        if entity.valid and entity and entity.position then
            if ((pos.x - entity.position.x)^2 + (pos.y - entity.position.y)^2 < dist^2) then
                entity.destroy()
            end
        end
    end
end

function RemoveDecorationsArea(surface, area)
    surface.destroy_decoratives(area)
end
