--control.lua

-- Credit:
-- -- Oarc's Multiplayer Spawner
-- -- -- Much of the resource code is based on Oarc's work
-- -- The Oddlers Factorio World
-- -- -- this depends on the Factorio Earth (formerly 'factorio world') mod being installed
-- -- by TheOverwatcher's Team Mod
-- -- -- The team code and lobby are pulled from this mod.  Many thanks!
--
-- Feel free to re-use anything you want. It would be nice to give me credit if you can.

mod_gui = require("mod-gui")
require("scripts/config")
require("scripts/coe_gui")
require("scripts/coe_setup")
require("scripts/oarc_utils_coe")

script.on_init(function() OnInit() end)
script.on_event(defines.events.on_gui_click,       function(event) OnGuiClick(event) end)
script.on_event(defines.events.on_player_created,  function(event) OnPlayerCreated(event) end)
script.on_event(defines.events.on_chunk_generated, function(event) OnChunkGenerated(event) end)

function OnInit()
  MakeLobby()
  if not global.coe then
    BuildCities()
  end -- if
end -- OnInit

function SelectCity(player, frame)
  local ui_city_list = frame.coe_cities_dropdown
  local name = ui_city_list.get_item(ui_city_list.selected_index)
  local city = GetCityByName(name)

  game.print({"", player.name, ": ", city.name, "(", city.x, ",", city.y, ")"})
  if city.resources_generated == nil then -- only chart if they haven't been
    player.force.chart(global.surface, {{city.x - CHART_AREA, city.y - CHART_AREA}, {city.x + CHART_AREA, city.y + CHART_AREA}})
  end -- if

  TeleportToCity(player, city)
end -- SelectCity

function SelectPlayer(player, frame)
  local ui_player_list = frame.coe_players_dropdown
  local target_player_name = ui_player_list.get_item(ui_player_list.selected_index)
  local target_player = GetPlayerByName(target_player_name)
  local destination = target_player.position

  game.print({"", player.name, " -> ", target_player.name, "(", destination.x, ",", destination.y, ")"})
  player.teleport({destination.x + GetRandomAmount(TELEPORT_WOBBLE), destination.y + GetRandomAmount(TELEPORT_WOBBLE)}, global.surface)
end -- SelectPlayer

function TeleportToCity(player, city)
  RemoveAliens(city)

  -- workaround because water won't persist when created earlier
  CreateCityTiles(city) -- ? can this be moved to OnChunkGenerated?

  player.teleport({city.x + GetRandomAmount(TELEPORT_WOBBLE), city.y + GetRandomAmount(TELEPORT_WOBBLE)}, global.surface)
  if global.coe.teams then
    player.force = game.forces[city.name]
  end -- if

end -- TeleportToCity

-- When a chunk is generated, check to see if it is within a range of a city.  If so, perform alien adjustments...
-- event has a position, each city has a position
function OnChunkGenerated(event)
  for index, city in ipairs(global.coe.cities) do
    local chunk_position = {x = (event.position.x * CHUNK_SIZE), y = (event.position.y * CHUNK_SIZE)}
    local distance = CalculateDistance(chunk_position, city.position)
    -- game.print({"", chunk_position, " : ", city.position, " - ", distance})
    if distance < SAFE_AREA_SIZE  then
      RemoveAliensInArea(event.area)
    end
    if distance < NO_LARGE_WORMS_SIZE then
      ReplaceLargerWormsInArea(event.area)
    end
  end
end -- OnChunkGenerated
