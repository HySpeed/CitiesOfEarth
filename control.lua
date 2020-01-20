--control.lua

-- Credit:
-- -- Oarc's Multiplayer Spawner
-- -- -- Much of the resource code is based on Oarc's work, and it depends on the Factorio World mod being installed.
-- -- by TheOverwatcher's Team Mod
-- -- -- The team code and lobby are pulled from this mod.  Many thanks!
--
-- Feel free to re-use anything you want. It would be nice to give me credit if you can.

require("mod-gui")
require("scripts/config")
require("scripts/coe_gui")
require("scripts/coe_setup")
require("scripts/oarc_utils_coe")

script.on_init(function() OnInit() end)
script.on_event(defines.events.on_gui_click, function(event) OnGuiClick(event) end)
script.on_event(defines.events.on_player_created, function(event) OnPlayerCreated(event) end)

function OnInit()
  MakeLobby()
  if not global.coe then
    BuildCityList()
  end -- if
end -- OnInit

function SelectCity(event, player, frame)
  local ui_city_list = frame.coe_cities_dropdown
  local target_city_name = ui_city_list.get_item(ui_city_list.selected_index)
  local target_city = GetCityByName(target_city_name)

  game.print({"", player.name, ": ", target_city.name, "(", target_city.x, ",", target_city.y, ")"})
  if (target_city.resgen == nil) then -- only gen resources if they haven't been
    ChartAndGenerateArea(player, target_city)
  end -- if

  RemoveAliens(global.surface, target_city)
  TeleportToCity(event, player, target_city)
end -- SelectCity

function SelectPlayer(event, player, frame)
  local ui_player_list = frame.coe_players_dropdown
  local target_player_name = ui_player_list.get_item(ui_player_list.selected_index)
  local target_player = GetPlayerByName(target_player_name)
  local destination = target_player.position
  
  game.print({"", player.name, " -> ", target_player.name, "(", destination.x, ",", destination.y, ")"})
  player.teleport({destination.x + GetRandomAmount(TELEPORT_WOBBLE), destination.y + GetRandomAmount(TELEPORT_WOBBLE)}, global.surface)
end -- SelectPlayer

function ChartAndGenerateArea(player, city)
  local surface = global.surface
  surface.request_to_generate_chunks({city.x, city.y}, 6)
  surface.force_generate_chunk_requests()
  player.force.chart(surface, {{city.x - CHART_AREA, city.y - CHART_AREA}, {city.x + CHART_AREA, city.y + CHART_AREA}})

  GenerateStartingResources(surface, city)
  city.resgen = true -- mark resources as generated
end -- ChartAndGenerateArea

function TeleportToCity(event, player, city)
  player.teleport({city.x + GetRandomAmount(TELEPORT_WOBBLE), city.y + GetRandomAmount(TELEPORT_WOBBLE)}, global.surface)
  player.force = game.forces[city.name]
end -- TeleportToCity