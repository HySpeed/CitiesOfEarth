-- oarc_utils_coe.lua
-- Nov 2016 / June 2018
-- 
-- general purpose utility functions for factorio
-- customized / simplified for Cities Of Earth

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
  if (diameter > 0) then
    for y=0, diameter do
      for x=0, diameter do
        if (not ENABLE_RESOURCE_SHAPE_CIRCLE or ((x-midPoint)^2 + (y-midPoint)^2 < midPoint^2)) then
          surface.create_entity({name=resourceName, amount=amount, position={pos.x+x, pos.y+y}})
        end
      end
    end
  end
end

-- Removes the entity type from the area given
-- Only if it is within given distance from given position.
function RemoveInCircle(surface, area, type, pos, dist)
  for key, entity in pairs(surface.find_entities_filtered({area=area, type=type})) do
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

---------
-- Aliens
---------

function RemoveAliens(surface, city)
  local safeArea = {{city.x - SAFE_AREA_SIZE, city.y - SAFE_AREA_SIZE}, {city.x + SAFE_AREA_SIZE, city.y + SAFE_AREA_SIZE}}
  local warnArea = {{city.x - WARN_AREA_SIZE, city.y - WARN_AREA_SIZE}, {city.x + WARN_AREA_SIZE, city.y + WARN_AREA_SIZE}}

  RemoveAliensInArea(surface, safeArea)
  ReduceAliensInArea(surface, warnArea, WARN_AREA_REDUCTION_RATIO)
end

function RemoveAliensInArea(surface, area)
  for _, entity in pairs(surface.find_entities_filtered{area = area, force = "enemy"}) do
    entity.destroy()
  end
end

-- Make an area safer
-- Reduction factor divides the enemy spawns by that number. 2 = half, 3 = third, etc...
-- Also removes all big and huge worms in that area
function ReduceAliensInArea(surface, area, reductionFactor)
  for _, entity in pairs(surface.find_entities_filtered{area = area, force = "enemy"}) do
    if (math.random(0,reductionFactor) > 0) then
      entity.destroy()
    end
  end

  -- Remove all big and huge worms
  for _, entity in pairs(surface.find_entities_filtered{area = area, name = "medium-worm-turret"}) do
    entity.destroy()
  end
  for _, entity in pairs(surface.find_entities_filtered{area = area, name = "big-worm-turret"}) do
    entity.destroy()
  end
end

function GetAreaAroundPos(pos, dist)
  return {left_top     = {x = pos.x-dist, y = pos.y-dist},
          right_bottom = {x = pos.x+dist, y = pos.y+dist}}
end

-- return a random amount to vary teleporting
function GetRandomAmount(max)
  local result = 0
  while (result == 0) do
    result = math.random(-max,max)
  end
  return result
end

function printArea(label, area)
  game.print( "~" .. label .. ": " ..  area[1][1] .. "," .. area[1][2] .. ":" .. area[2][1] .. "," .. area[2][2])
end
