-- oarc_utils_coe.lua
-- 
-- general purpose utility functions for factorio from oarc
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
   
  CreateWaterStrip(surface, {x=city.x+WATER_SPAWN_OFFSET_X, y=city.y+WATER_SPAWN_OFFSET_Y  }, WATER_SPAWN_LENGTH, WATER_SPAWN_WIDTH)



  
  -- Generate oil patches
  local pos_x=city.x+START_RESOURCE_OIL_POS_X
  local pos_y=city.y+START_RESOURCE_OIL_POS_Y
  GenerateOilPatch(surface, "crude-oil", pos_x, pos_y, START_OIL_AMOUNT)

  local resourcePos
  
  -- Generate stone
  resourcePos = {x=city.x+START_RESOURCE_STONE_POS_X, y=city.y+START_RESOURCE_STONE_POS_Y}
  GenerateResourcePatch(surface, "stone", START_RESOURCE_STONE_SIZE, resourcePos, START_STONE_AMOUNT)

  -- Generate coal
  resourcePos = {x=city.x+START_RESOURCE_COAL_POS_X, y=city.y+START_RESOURCE_COAL_POS_Y}
  GenerateResourcePatch(surface, "coal", START_RESOURCE_COAL_SIZE, resourcePos, START_COAL_AMOUNT)

  -- Generate copper ore
  resourcePos = {x=city.x+START_RESOURCE_COPPER_POS_X, y=city.y+START_RESOURCE_COPPER_POS_Y}
  GenerateResourcePatch(surface, "copper-ore", START_RESOURCE_COPPER_SIZE, resourcePos, START_COPPER_AMOUNT)

  -- Generate iron ore
  resourcePos = {x=city.x+START_RESOURCE_IRON_POS_X, y=city.y+START_RESOURCE_IRON_POS_Y}
  GenerateResourcePatch(surface, "iron-ore", START_RESOURCE_IRON_SIZE, resourcePos, START_IRON_AMOUNT)

  -- Generate uranium
  resourcePos = {x=city.x+START_RESOURCE_URANIUM_POS_X, y=city.y+START_RESOURCE_URANIUM_POS_Y}
  GenerateResourcePatch(surface, "uranium-ore", START_RESOURCE_URANIUM_SIZE, resourcePos, START_URANIUM_AMOUNT)

  -- Tree generation is needed
  resourcePos = {x=city.x+START_RESOURCE_TREE_POS_X, y=city.y+START_RESOURCE_TREE_POS_Y}
  GenerateResourcePatch(surface, "tree-02", START_RESOURCE_TREE_SIZE, resourcePos, START_TREE_AMOUNT)
end

-- Create a horizontal line of water
function CreateWaterStrip(surface, leftPos, length, width)
  local waterTiles = {}
  for w = 0, width, 1 do
    for l = 0, length, 1 do
      table.insert(waterTiles, {name = "water", position={leftPos.x+l,leftPos.y+w}})
    end
  end  
  surface.set_tiles(waterTiles)
end 

-- Generate an oil patch, of a certain size/amount at a pos.
function GenerateOilPatch(surface, resourceName, pos_x, pos_y, amount)
  if game.entity_prototypes[resourceName] then
    for i=1,START_RESOURCE_OIL_NUM_PATCHES do
      surface.create_entity({name=resourceName, amount=amount, position={pos_x, pos_y}})
      pos_x = pos_x+START_RESOURCE_OIL_X_OFFSET
      pos_y = pos_y+START_RESOURCE_OIL_Y_OFFSET
    end
  end
end  


-- Generate a resource patch, of a certain size/amount at a pos.
function GenerateResourcePatch(surface, resourceName, diameter, pos, amount)
  if game.entity_prototypes[resourceName] then
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
end

-- Removes the entity type from the area given
-- Only if it is within given distance from given position.
function RemoveInCircle(surface, area, type, pos, dist)
  if game.entity_prototypes[type] then
    for key, entity in pairs(surface.find_entities_filtered({area=area, type=type})) do
      if entity.valid and entity and entity.position then
        if ((pos.x - entity.position.x)^2 + (pos.y - entity.position.y)^2 < dist^2) then
          entity.destroy()
        end
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
  local removed = false
  for _, entity in pairs(surface.find_entities_filtered{area = area, force = "enemy"}) do
    entity.destroy()
    removed = true
  end
  if (removed == true) then
    game.print( {"coe.removed-aliens-message"} )
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
