--coe_data.lua

--Teleport to these major city areas (FOR SCALE 1 - normal map)
--Lagos            0,      0 (must spawn at: 2160, 960)
--Beijing       1150,   -430 
--Cairo          190,   -290 
--Delhi          720,   -300
--Edmonton     -1500,   -650
--Los Angeles  -1500,   -450
--Omsk          1000,   -700
--Mexico City  -1280,   -220
--Moscow         330,   -650
--New York     -1050,   -400
--Paris         -100,   -500
--Sao Paulo     -650,    180
--Sydney        1500,    400

function build_city_list()
  global.coe = {["cities"] = {}, ["players"] = {}}
--    game.write_file("coe.log", "") -- creates empty log file

  local indexes = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
  local settings_global = settings.global -- cached for performance
  local city = nil

  for _, slot in pairs(indexes) do
    city = read_city(settings_global, slot)
    if (city.name ~= nil and city.name ~= slot) then
      table.insert(global.coe.cities, create_city(city))
--    game.write_file("coe.log", city.name.."("..city.x..","..city.y..")\n", "true")
    end
  end  
end

function read_city(settings_global, slot)
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
end

function create_city(city)
  local scale = settings.global["map-gen-scale"].value
  local use_large_map = settings.global["use-large-map"].value
  local large = 1
  if (use_large_map) then
    large = 2
  end  
  
  city.x = city.x * scale * large
  city.y = city.y * scale * large
  return city
end

function get_city_by_name(name)
  for _, city in pairs(global.coe.cities) do
    if (city.name == name) then
      return city
    end
  end
end

function build_city_name_list(city_list)
  local result = {}
  for index, city in ipairs(city_list) do
    result[index] = city.name
  end
  return result
end

function build_player_name_list()
  local result = {}
  build_player_list()
  for index, player in pairs(global.coe.players) do
    result[index] = player.name
  end
  return result
end

function build_player_list()
  global.coe.players = {}
  for _, player in pairs(game.players) do
    table.insert(global.coe.players, player)
  end
end

function get_player_by_name(name)
  for _, player in pairs(global.coe.players) do
    if (player.name == name) then
      return player
    end
  end
end

-- Compare the spawn of factorio world and the spawn of Cities of Earth.
-- They need to match for the teleporting to be accurate.
function is_spawn_good()
  local result = false
  local settings_global = settings.global -- cached for performance
  local fw_spawn_x = settings_global["spawn-x"].value
  local fw_spawn_y = settings_global["spawn-y"].value
  local coe_spawn_x = settings_global["coe_spawn-x"].value
  local coe_spawn_y = settings_global["coe_spawn-y"].value

  if (fw_spawn_x == coe_spawn_x and fw_spawn_y == coe_spawn_y) then
    result = true
  end
  return result
end
