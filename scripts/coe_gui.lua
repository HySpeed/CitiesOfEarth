--coe_gui.lua

function OnGuiClick(event)
  local player  = game.players[event.player_index]
  local element = event.element
  local frame   = element.parent
  local dialog  = element.parent.parent

  if (element.name == "coe_button_show_targets" ) then
    ShowTargetChoices(event, player)
  elseif (element.name == "coe_button_city_go") then
    SelectCity(player, frame)
    dialog.parent.destroy()
  elseif (element.name == "coe_button_player_go") then
    SelectPlayer(player, frame)
    dialog.parent.destroy()
  elseif (element.name == "coe_button_cancel") then
    dialog.destroy()
  elseif (element.name == "coe_button_info_close") then
    frame.destroy()
  end
end -- OnGuiClick

function OnPlayerCreated(event)
  local player = game.players[event.player_index]
  CreateButton_ShowTargets(player)
  CreateShowInfoFrame(player)
  player.teleport({ 0, 8 }, game.surfaces["Lobby"])
end -- OnPlayer_JoinedGame

function CreateButton_ShowTargets(player)
  local flow = mod_gui.get_button_flow(player)
  if (not flow.coe_button_show_targets) then
    local button = flow.add({
      type = "sprite-button",
      name = "coe_button_show_targets",
      style = mod_gui.button_style,
      sprite = "show_targets_list",
      tooltip = {"coe-tooltip.button-show-targets"}
    })
  end
end -- CreateButton_ShowTargets

function ShowTargetChoices(event, player)
  local gui = player.gui.center
  if (gui.coe_choose_target == nil) then
    local spawn_configured = IsValidSpawnSettings() -- error is displayed if setup is wrong
    BuildTargetListFrame(gui, player, spawn_configured)
  end -- if
end -- ShowTargetChoices

function BuildTargetListFrame(gui, player, spawn_configured)
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

  local city_names = BuildCityNameList(global.coe.cities)
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

  -- only show player list if not in 'lobby'
  if (player.surface == global.surface) then
    local player_names = BuildPlayerNameList()
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
  end -- if

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

  if (spawn_configured ~= true) then
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
  end -- if
end -- BuildTargetListFrame

function CreateShowInfoFrame(player)
  local gui = player.gui.center
  if (not gui.coe_frame_show_info) then
    local info_frame = gui.add({
      type = "frame",
      name = "coe_frame_show_info",
      style = "frame",
      direction = "vertical",
      caption = {"coe.title-show-info"}
    })

    info_frame.add({
      type = "label",
      name = "coe_info_text_1",
      caption = {"coe.info-text-1"}
    })

    info_frame.add({
      type = "label",
      name = "coe_info_text_2",
      caption = {"coe.info-text-2"}
    })

    info_frame.add({
      type = "button",
      name = "coe_button_info_close",
      caption = {"coe.button-info-close"}
    })
  end -- if
end -- CreateShowInfoFrame
