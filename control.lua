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
  for _, player in pairs (game.players) do
    create_button_show_cities(player)
  end
end

function select_city(event, player, frame)
  local ui_list = frame.coe_city_dropdown
  local city_name = ui_list.get_item(ui_list.selected_index)
  local city = get_city_by_name(city_name)

  print_choice(player, city)  
  if (city.resgen == nil) then -- opnly gen resources if they haven't been
    chart_and_generate(player, city)
  end

  player.teleport({city.x+GetRandomAmount(SPAWN_WOBBLE), city.y+GetRandomAmount(SPAWN_WOBBLE)})
end

function print_choice(player, city)
  local genres = {"coe.generating-resources"}
  if (city.resgen ~= nil) then
    genres = {"coe.not-generating-resources"}
  end  
  game.print({"", player.name, ": ", city.name, "(", city.x, ",", city.y, "): ", genres} )
end

function chart_and_generate(player, city)
  -- Chart the area
  player.surface.request_to_generate_chunks({city.x, city.y}, 6)
  player.surface.force_generate_chunk_requests()
  player.force.chart(player.surface, {{city.x-CHART_AREA, city.y-CHART_AREA}, {city.x+CHART_AREA, city.y+CHART_AREA}})

  GenerateStartingResources(player.surface, city)
  RemoveAliens(player.surface, city)
  city.resgen = true -- mark resources as generated
end
