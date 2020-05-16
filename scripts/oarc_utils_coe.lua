-- oarc_utils_coe.lua
-- 
-- general purpose utility functions for factorio from oarc
-- customized / simplified for Cities Of Earth

--------------------------------------------------------------------------------
-- Resource patch and starting area generation
--------------------------------------------------------------------------------

-- Generate the basic starter resource around a given location.
function GenerateStartingResources(city)
  global.surface.request_to_generate_chunks({city.x, city.y}, 6)
  global.surface.force_generate_chunk_requests()

  local area = {{city.x-CHUNK_SIZE, city.y-CHUNK_SIZE}, {city.x+CHUNK_SIZE, city.y+CHUNK_SIZE}}

  -- Remove trees/resources inside the spawn area
  RemoveByTypesInCircle(area, city, ENFORCE_LAND_AREA_TILE_DIST + 10)
  RemoveDecorationsArea(area)

  if global.coe.create then
    -- Generate oil patches
    local pos_x=city.x+START_RESOURCE_OIL_POS_X
    local pos_y=city.y+START_RESOURCE_OIL_POS_Y
    GenerateOilPatch("crude-oil", pos_x, pos_y, START_OIL_AMOUNT)

    local resourcePos
    -- Generate stone
    resourcePos = {x=city.x+START_RESOURCE_STONE_POS_X, y=city.y+START_RESOURCE_STONE_POS_Y}
    GenerateResourcePatch("stone", START_RESOURCE_STONE_SIZE, resourcePos, START_STONE_AMOUNT)

    -- Generate coal
    resourcePos = {x=city.x+START_RESOURCE_COAL_POS_X, y=city.y+START_RESOURCE_COAL_POS_Y}
    GenerateResourcePatch("coal", START_RESOURCE_COAL_SIZE, resourcePos, START_COAL_AMOUNT)

    -- Generate copper ore
    resourcePos = {x=city.x+START_RESOURCE_COPPER_POS_X, y=city.y+START_RESOURCE_COPPER_POS_Y}
    GenerateResourcePatch("copper-ore", START_RESOURCE_COPPER_SIZE, resourcePos, START_COPPER_AMOUNT)

    -- Generate iron ore
    resourcePos = {x=city.x+START_RESOURCE_IRON_POS_X, y=city.y+START_RESOURCE_IRON_POS_Y}
    GenerateResourcePatch("iron-ore", START_RESOURCE_IRON_SIZE, resourcePos, START_IRON_AMOUNT)

    -- Generate uranium
    resourcePos = {x=city.x+START_RESOURCE_URANIUM_POS_X, y=city.y+START_RESOURCE_URANIUM_POS_Y}
    GenerateResourcePatch("uranium-ore", START_RESOURCE_URANIUM_SIZE, resourcePos, START_URANIUM_AMOUNT)

    -- Tree generation is needed
    resourcePos = {x=city.x+START_RESOURCE_TREE_POS_X, y=city.y+START_RESOURCE_TREE_POS_Y}
    GenerateResourcePatch("tree-02", START_RESOURCE_TREE_SIZE, resourcePos, START_TREE_AMOUNT)
    city.resources_generated = true -- mark resources as generated
  end
end -- GenerateStartingResources

-- Removes the entity types from the area given
-- Only if it is within given distance from given position.
function RemoveByTypesInCircle(area, pos, dist)
  for _, entity in pairs(global.surface.find_entities_filtered{area = area, type = {"tree", "resource", "cliff"}}) do
    if entity and entity.valid and entity.position then
      if ((pos.x - entity.position.x)^2 + (pos.y - entity.position.y)^2 < dist^2) then
        entity.destroy()
      end
    end
  end
end

-- Generate an oil patch, of a certain size/amount at a pos.
function GenerateOilPatch(resourceName, pos_x, pos_y, amount)
  if game.entity_prototypes[resourceName] then
    for i=1,START_RESOURCE_OIL_NUM_PATCHES do
      global.surface.create_entity({name=resourceName, amount=amount, position={pos_x, pos_y}})
      pos_x = pos_x+START_RESOURCE_OIL_DISTANCE_X
      pos_y = pos_y+START_RESOURCE_OIL_DISTANCE_Y
    end
  end
end

-- Generate a resource patch, of a certain size/amount at a pos.
function GenerateResourcePatch(resourceName, diameter, pos, amount)
  if game.entity_prototypes[resourceName] then
    local midPoint = math.floor(diameter/2)
    if diameter > 0 then
      for y=0, diameter do
        for x=0, diameter do
          if (not ENABLE_RESOURCE_SHAPE_CIRCLE or ((x-midPoint)^2 + (y-midPoint)^2 < midPoint^2)) then
            global.surface.create_entity({name=resourceName, amount=amount, position={pos.x+x, pos.y+y}})
          end
        end
      end
    end
  end
end

-- Create city tiles:
-- - Water at spawn
-- - Cement at spawn
function CreateCityTiles(city)
  if not city.tiles then
    if global.coe.create then
      CreateSurfaceTiles(city.x, city.y, WATER_NAME, WATER_SPAWN_OFFSET_X, WATER_SPAWN_OFFSET_Y, WATER_SPAWN_DISTANCE_X, WATER_SPAWN_DISTANCE_Y)
    end
    CreateSurfaceTiles(city.x, city.y, CONCRETE_NAME, CONCRETE_SPAWN_OFFSET_X, CONCRETE_SPAWN_OFFSET_Y, CONCRETE_SPAWN_DISTANCE_X, CONCRETE_SPAWN_DISTANCE_Y)
    city.tiles = true
  end
end -- CreateCityTiles

-- Create Surface Tiles - put desired tiles in a table, then set those on the surface.
function CreateSurfaceTiles(pos_x, pos_y, tileName, offset_x, offset_y, distance_x, distance_y)
  local tiles = {}
  for index_x = 0, distance_x, 1 do
    for index_y = 0, distance_y, 1 do
      table.insert( tiles, {name=tileName, position={(pos_x + offset_x + index_x), (pos_y + offset_y + index_y)}})
    end -- for y
  end -- for x
  global.surface.set_tiles(tiles)
end -- CreateSurfaceTiles

function RemoveDecorationsArea(area)
  global.surface.destroy_decoratives(area)
end


---------
-- Aliens
---------
function RemoveAliens(city)
  local safeArea = {{city.x - SAFE_AREA_SIZE, city.y - SAFE_AREA_SIZE}, {city.x + SAFE_AREA_SIZE, city.y + SAFE_AREA_SIZE}}
  local wormArea = {{city.x - NO_LARGE_WORMS_SIZE, city.y - NO_LARGE_WORMS_SIZE}, {city.x + NO_LARGE_WORMS_SIZE, city.y + NO_LARGE_WORMS_SIZE}}

  RemoveAliensInArea(safeArea)
  -- ReduceAliensInArea(warnArea)
  ReplaceLargerWormsInArea(wormArea)
end

function RemoveAliensInArea(area)
  for _, entity in pairs(global.surface.find_entities_filtered{area = area, force = "enemy"}) do
    entity.destroy()
  end
end

-- Make an area safer
-- Reduction factor divides the enemy spawns by that number. 2 = half, 3 = third, etc...
-- Also replaces larger worms in that area with small ones
function ReduceAliensInArea(area)
  for _, entity in pairs(global.surface.find_entities_filtered{area = area, force = "enemy"}) do
    local rand = math.random(1,REDUCTION_FACTOR) -- disabled because it would sometimes return 'nil'
    if rand > 1 then
      game.print("*reducing: " .. entity.name)
      entity.destroy()
    end
  end
  ReplaceLargerWormsInArea(area)
end

-- Replace larger worms in area with small ones
function ReplaceLargerWormsInArea(area)
  -- Remove all large+ worms
  for _, entity in pairs(global.surface.find_entities_filtered{area = area, name = {"medium-worm-turret", "big-worm-turret", "behemoth-worm-turret"}}) do
    local position = entity.position;
    entity.destroy()
    global.surface.create_entity{name = "small-worm-turret", position = position, force = game.forces.enemy}
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
    result = math.random(-max, max)
  end
  return result
end

function CalculateDistance(position_1, position_2)
  return math.sqrt((position_1.x - position_2.x)^2 + (position_1.y - position_2.y)^2)
end -- CalculateDistance

function PrintArea(label, area)
  game.print( "~" .. label .. ": " ..  area.left_top .. ";" .. area.right_bottom .. ".")
end

function PrintArea2(label, area)
  game.print( "~" .. label .. ": " ..  area[1][1] .. "," .. area[1][2] .. ":" .. area[2][1] .. "," .. area[2][2])
end
