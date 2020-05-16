--coe_setup.lua

function BuildCities()
  global.surface = game.surfaces["nauvis"]
  global.coe = {["cities"] = {}, ["players"] = {}}
  -- game.write_file("coe.log", "") -- creates empty log file

  local indexes = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
  global.coe.teams = settings_global["coe_teams"].value
  global.coe.create = settings_global["coe_create"].value
  local city = nil

  for _, slot in pairs(indexes) do
    city = ReadCityFromSettings(settings_global, slot)
    if (city.name ~= nil and city.name ~= slot) then
      city = CreateCity(city)
      table.insert(global.coe.cities, city )
      CreateForce(city)
      GenerateStartingResources(city)
      -- game.write_file("coe.log", city.name.."("..city.x..","..city.y..")\n", "true")
    end -- if
  end -- for

  SetCeaseFires()
end -- BuildCities

-- the string of 'mod' + 'n' + 'slot' equals the array index string
function ReadCityFromSettings(settings_global, slot)
  local city = {}
  local mod = "coe_"
  local n = "n_"
  local x = "x_"
  local y = "y_"

  if (settings_global[mod..n..slot] ~= nil) then
    city.name = settings_global[mod..n..slot].value
    city.x    = settings_global[mod..x..slot].value
    city.y    = settings_global[mod..y..slot].value
  end
  return city
end -- ReadCity

function CreateCity(city)
  local scale = settings_global["map-gen-scale"].value
  local use_large_map = settings_global["use-large-map"].value
  local large_map = 1

  if use_large_map then
    large_map = 2
  end

  city.x = city.x * scale * large_map
  city.y = city.y * scale * large_map
  city.position = {x = city.x, y = city.y}
  city.tiles = false
  return city
end -- CreateCity

function CreateForce(city)
  if global.coe.teams then
    game.create_force(city.name)
    game.forces[city.name].set_spawn_position({ city.x, city.y }, global.surface)
  end -- if
end -- CreateForce

-- loop through each force, setting cease fire with the others - needs two loops
function SetCeaseFires()
  if global.coe.teams then
    for _, forceOuter in pairs(game.forces) do
      if "enemy" ~= forceOuter.name then 
        for  _, forceInner in pairs(game.forces) do
          if "enemy" ~= forceInner.name then
            forceOuter.set_cease_fire(forceInner, true)
          end -- if
        end -- for
      end -- if
      forceOuter.friendly_fire = false
    end -- for
  end -- if
end -- SetCeaseFires

function GetCityByName(name)
  for _, city in pairs(global.coe.cities) do
    if city.name == name then
      return city
    end
  end
end -- GetCityByName

function BuildCityNameList(city_list)
  local result = {}
  for index, city in ipairs(city_list) do
    result[index] = city.name
  end
  return result
end -- BuildCityNameList

function BuildPlayerNameList()
  local result = {}
  BuildPlayerList()
  for index, player in pairs(global.coe.players) do
    result[index] = player.name
  end
  return result
end -- BuildPlayerNameList

function BuildPlayerList()
  global.coe.players = {}
  for _, player in pairs(game.players) do
    table.insert(global.coe.players, player)
  end
end -- BuildPlayerList

function GetPlayerByName(name)
  for _, player in pairs(global.coe.players) do
    if player.name == name then
      return player
    end
  end
end -- GetPlayerByName

-- Compare the spawn of factorio world and the spawn of Cities of Earth.
-- They need to match for the teleporting to be accurate.
function IsValidSpawnSettings()
  local result = false
  local fe_spawn_x = settings_global["spawn-x"].value
  local fe_spawn_y = settings_global["spawn-y"].value
  local coe_spawn_x = settings_global["coe_spawn-x"].value
  local coe_spawn_y = settings_global["coe_spawn-y"].value

  if (fe_spawn_x == coe_spawn_x and fe_spawn_y == coe_spawn_y) then
    result = true
  end
  return result
end -- IsValidSpawnSettings

function MakeLobby()
  if (game.surfaces[LOBBY_NAME] == nil) then
    game.create_surface(LOBBY_NAME, { width = 96, height = 32, starting_area = "big", water = "none" })
  end
end -- MakeLobby
