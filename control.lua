--control.lua

-- Credit:
--  Oarc's Multiplayer Spawner
-- -- Much of the resource code is based on Oarc's work, and it depends on the Factorio World mod being installed.
--  ToDo List
-- -- Much of the UI code is from that mod.
--
-- Feel free to re-use anything you want. It would be nice to give me credit if you can.

require("mod-gui")
require("scripts/config")
require("scripts/coe_gui")
require("scripts/coe_data")
require("scripts/oarc_utils_coe")

script.on_init(function() on_init() end)
script.on_event(defines.events.on_gui_click, function(event) on_gui_click(event) end)
script.on_event(defines.events.on_player_joined_game, function(event) on_player_joined_game(event) end)

function on_init()
  if not global.coe then
    build_city_list()
  end  
  for _, player in pairs(game.players) do
    create_button_show_targets(player)
  end
end

function select_city(event, player, frame)
  local ui_city_list = frame.coe_cities_dropdown
  local target_city_name = ui_city_list.get_item(ui_city_list.selected_index)
  local target_city = get_city_by_name(target_city_name)

  game.print({"", player.name, ": ", target_city.name, "(", target_city.x, ",", target_city.y, ")"})
  if (target_city.resgen == nil) then -- only gen resources if they haven't been
    chart_and_generate(player, target_city)
  end

  RemoveAliens(player.surface, target_city)
  player.teleport({target_city.x + GetRandomAmount(TELEPORT_WOBBLE), target_city.y + GetRandomAmount(TELEPORT_WOBBLE)})
end

function select_player(event, player, frame)
  local ui_player_list = frame.coe_players_dropdown
  local target_player_name = ui_player_list.get_item(ui_player_list.selected_index)
  local target_player = get_player_by_name(target_player_name)
  local destination = target_player.position
  
  game.print({"", player.name, " -> ", target_player.name, "(", destination.x, ",", destination.y, ")"})
  player.teleport({destination.x + GetRandomAmount(TELEPORT_WOBBLE), destination.y + GetRandomAmount(TELEPORT_WOBBLE)})
end

function chart_and_generate(player, city)
  local surface = player.surface
  surface.request_to_generate_chunks({city.x, city.y}, 6)
  surface.force_generate_chunk_requests()
  player.force.chart(player.surface, {{city.x - CHART_AREA, city.y - CHART_AREA}, {city.x + CHART_AREA, city.y + CHART_AREA}})

  GenerateStartingResources(surface, city)
  city.resgen = true -- mark resources as generated
end
