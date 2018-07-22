--coe_gui.lua

function on_gui_click(event)
  local player = game.players[event.player_index]
  local element = event.element
  local frame = element.parent
  local ui = element.parent.parent

  if (element.name == "coe_button_show_targets" ) then
    show_target_choices(event, player)
  elseif (element.name == "coe_button_city_go") then
    select_city(event, player, frame)
    ui.parent.destroy()
  elseif (element.name == "coe_button_player_go") then
    select_player(event, player, frame)
    ui.parent.destroy()
  elseif (element.name == "coe_button_cancel") then
    ui.destroy()
  end
end

function on_player_joined_game(event)
  local player = game.players[event.player_index]
  create_button_show_targets(player)
end

function create_button_show_targets(player)
  local flow = mod_gui.get_button_flow(player)
  if (not flow.coe_button_show_targets) then
    local button = flow.add({
      type = "sprite-button",
      name = "coe_button_show_targets",
      style = mod_gui.button_style,
      sprite = "show_targets_list",
      tooltip = {"coe-tooltip.button-show-targets"}
    })
    button.style.visible = true
  end
end

function show_target_choices(event, player)
  local gui = player.gui.center
  if (gui.coe_choose_target == nil) then
    local good_spawn = is_spawn_good()
    build_target_list_frame(gui, good_spawn)
  end  
end

function build_target_list_frame(gui, good_spawn)
  local frame = gui.add({
    type = "frame",
    name = "coe_choose_target",
    style = "frame",
    direction = "vertical",
    caption = {"coe.title-choose-target"}
  })

  local city_and_player_flow = frame.add({
    type = "flow",
    name = "coe_city_and_player_flow",
    direction = "horizontal"
  })
  
  local city_flow = city_and_player_flow.add({
    type = "flow",
    name = "coe_city_flow",
    direction = "vertical"
  })
  
  local city_names = build_city_name_list(global.coe.cities)
  city_flow.add({
    type = "drop-down",
    name = "coe_cities_dropdown",
    items = city_names,
    selected_index = 1
  })

  city_flow.add({
    type = "button",
    name = "coe_button_city_go",
    caption = {"coe.button-city-go"}
  })

  local player_flow = city_and_player_flow.add({
    type = "flow",
    name = "coe_player_flow",
    direction = "vertical"
  })
  
  local player_names = build_player_name_list()
  player_flow.add({
    type = "drop-down",
    name = "coe_players_dropdown",
    items = player_names,
    selected_index = 1 -- 0?
  })

  player_flow.add({
    type = "button",
    name = "coe_button_player_go",
    caption = {"coe.button-player-go"}
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
