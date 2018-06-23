--control.lua

-- Credit:
--  Oarc's Multiplayer Spawner
-- -- Much of the resource code is based on Oarc's work, and it depends on the Factorio World mod being installed.
--  ToDo List
-- -- Much of the UI code is from that mod.
--
-- Feel free to re-use anything you want. It would be nice to give me credit if you can.

require("config")
require("mod-gui")
require("oarc_utils_coe")

script.on_event(defines.events.on_gui_click, function(event)
    on_gui_click(event)
end)

script.on_event( defines.events.on_player_created,     function(event) show_city_choices(event) end)
script.on_event( defines.events.on_player_joined_game, function(event) show_city_choices(event) end)
script.on_event( defines.events.on_player_respawned,   function(event) show_city_choices(event) end)

function build_city_list()
  global.coe = {["cities"] = {}}
  table.insert(global.coe.cities, create_city("Beijing",25000,-10000))
  table.insert(global.coe.cities, create_city("Cairo",4500,-6300))
  table.insert(global.coe.cities, create_city("Delhi",16000,-7000))
  table.insert(global.coe.cities, create_city("Edmonton",-27000,-14000))
  table.insert(global.coe.cities, create_city("Lagos",0,0))
  table.insert(global.coe.cities, create_city("Los Angeles",-30000,-9000))
  table.insert(global.coe.cities, create_city("Omsk",20000,-14000))
  table.insert(global.coe.cities, create_city("Mexico City",-26000,-5000))
  table.insert(global.coe.cities, create_city("Moscow",7000,-14000))
  table.insert(global.coe.cities, create_city("New York",-20000,-9000))
  table.insert(global.coe.cities, create_city("Paris",-2000,-10000))
  table.insert(global.coe.cities, create_city("Sao Paulo",-12000,5000))
  table.insert(global.coe.cities, create_city("Sydney",30000,8000))
end

function on_gui_click(event)
  local player = game.players[event.player_index]
  local element = event.element
  local frame = element.parent.parent

  if (element.name == "coe_button_go") then
    select_city(event, player, frame)
    frame.destroy()
  elseif (element.name == "coe_button_cancel") then
    frame.destroy()
  end
end

-- get selected string index (city)
-- get coords for city
-- todo: generate resources at city (if not exist) if force resources is checked, generate always
-- teleport player to city
function select_city(event, player, frame)
  local ui_list = frame.coe_city_dropdown
  local city_name = ui_list.get_item(ui_list.selected_index)
  local force_resgen = frame.coe_force_resgen.state
  local city = get_city_by_name(city_name)

  print_choice(city, force_resgen)  
  if (city.resgen == nil or force_resgen) then
    chart_and_generate(player, city)
  end

  player.teleport(city.x, city.y)
end

function get_city_by_name(name)
  for _, city in pairs(global.coe.cities) do
    if (city.name == name) then
      return city
    end
  end
end

function print_choice(city, force_resgen)
  local genres = {"coe.generating-resources"}
  if (city.resgen ~= nil and force_resgen ~= true) then
    genres = {"coe.not-generating-resources"}
  end  
  game.print({"", {"coe.selected-city"}, ": ", city.name .. " - ",  genres} )
end

function chart_and_generate(player, city)
  -- Chart the area first
  player.surface.request_to_generate_chunks({city.x, city.y}, 2)
  player.surface.force_generate_chunk_requests()
  player.force.chart(player.surface, {{city.x-CHART_AREA, city.y-CHART_AREA}, {city.x+CHART_AREA, city.y+CHART_AREA}})
  GenerateStartingResources(player.surface, city)
  city.resgen = true
end

function create_city(name, x, y)
  local city = {}
  city.name = name
  city.x = x
  city.y = y
  return city
end

function build_name_list(city_list)
  local result = {}
  for index, city in ipairs(city_list) do
    result[index] = city.name
  end
  return result
end

function show_city_choices(event)
  if not global.coe then
    build_city_list()
  end  
  
  local player = game.players[event.player_index]
  local gui = player.gui.center
  if (gui.coe_choose_city == nil) then
    build_gui_frame(gui)
  end  
end

function build_gui_frame(gui)
  local frame = gui.add({
    type = "frame",
    name = "coe_choose_city",
    style = "frame",
    direction = "vertical",
    caption = {"coe.title-choose-city"}
  })

  local names = build_name_list(global.coe.cities)
  frame.add({
    type = "drop-down",
    name = "coe_city_dropdown",
    items = names,
    selected_index = 2
  })

  frame.add({
    type = "checkbox",
    name = "coe_force_resgen",
    state = false,
    caption = {"coe.checkbox-force-resgen"},
    tooltip = {"coe-tooltip.checkbox-force-resgen"}
  })

  local controls_flow = frame.add({
      type = "flow",
      name = "coe_controls_flow",
      direction = "horizontal"
  })

  controls_flow.add({
    type = "button",
    name = "coe_button_cancel",
    caption = {"coe.button-cancel"}
  })

  controls_flow.add({
    type = "button",
    name = "coe_button_go",
    caption = {"coe.button-go"}
  })

  frame.add({
    type = "label",
    name = "coe_note_delay_1",
    caption = {"coe.note-delay-1"}
  })  

  frame.add({
    type = "label",
    name = "coe_note_delay_2",
    caption = {"coe.note-delay-2"}
  })  

end
