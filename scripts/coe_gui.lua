--coe_gui.lua

function on_gui_click(event)
  local player = game.players[event.player_index]
  local element = event.element
  local frame = element.parent.parent

  if (element.name == "coe_button_show_cities" ) then
    show_city_choices(event, player)
  elseif (element.name == "coe_button_go") then
    select_city(event, player, frame)
    frame.destroy()
  elseif (element.name == "coe_button_cancel") then
    frame.destroy()
  end
end

function on_player_joined_game(event)
  local player = game.players[event.player_index]
  create_button_show_cities(player)
end

function create_button_show_cities(player)
  local flow = mod_gui.get_button_flow(player)
  if (not flow.coe_button_show_cities) then
    local button = flow.add({
      type = "sprite-button",
      name = "coe_button_show_cities",
      style = mod_gui.button_style,
      sprite = "show_cities_list",
      tooltip = {"coe-tooltip.button-show-cities"}
    })
    button.style.visible = true
  end
end

function show_city_choices(event, player)
  local gui = player.gui.center
  if (gui.coe_choose_city == nil) then
    local good_spawn = is_spawn_good()
    build_city_list_frame(gui, good_spawn)
  end  
end

function build_city_list_frame(gui, good_spawn)
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
    selected_index = 1
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

  if (good_spawn ~= true) then
    frame.add({
      type = "label",
      name = "coe_bad_spawn_1",
      caption = {"coe.bad-spawn-1"}
    })  
    frame.add({
      type = "label",
      name = "coe_bad_spawn_2",
      caption = {"coe.bad-spawn-2"}
    })  
  end    
end
