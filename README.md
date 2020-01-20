# CitiesOfEarth
A Factorio mod that adds a city areas list to Factorio World (Earth)

This mod requires Factorio World (Earth) (v0.16.1+)  and that the initial spawn point be in west Africa.  The city locations are based on a 0,0 point of 2160, 960.

In order to prevent the map from wrapping, these are some world size limitations to use:
+ Size: 1 - normal, Max X:  4000, Max Y:   1900
+ Size: 2 - normal, Max X:  8000, Max Y:   3800
+ Size: 4 - normal, Max X: 16000, Max Y:   7600
+ Size: 6 - normal, Max X: 24000, Maxy Y: 11000
+ Size: 10 - large, Max X: 80000, Max Y:  38000
+ Spawn_X: 2160, Spawn_Y: 960

This gives you the entire world while stopping you from creating another world
Adjusting the spawn anywhere else cuts the other side of the world
Doing any part above/below the equator would also split the north/south

Teleport to these major city areas (for scale 1 NORMAL map)
+ Lagos            0,      0 (must spawn at: 2160, 960)
+ Beijing       1150,   -430 
+ Cairo          190,   -290 
+ Delhi          720,   -300
+ Edmonton     -1500,   -650
+ Los Angeles  -1500,   -450
+ Omsk          1000,   -700
+ Mexico City  -1280,   -220
+ Moscow         330,   -650
+ New York     -1050,   -400
+ Paris         -100,   -500
+ Sao Paulo     -650,    180
+ Sydney        1500,    400

Note: Large map multiplies all values by 2.

## todo:

## bugs:
+ I have seen where adding & removing cities in settings requires deleting mod-settings.dat for the changes to appear correctly.

v0.2.0
+ Added teams - non hostile.

v0.1.9
+ Updated to Factorio 0.17.

v0.1.8
+ bug: Added checks for resources before attempting to create them.
+ + This is to prevent errors with mods that remove or rename basic resources.  I will not adding support for alternate resources.

v0.1.7
+ Added 'Teleport to Player' ability

v0.1.6
+ Fixed version

v0.1.5
+ Changed requirements to Factorio World 0.16.1
+ + If this isn't available on the mod portal, see https://github.com/TheOddler/FactorioWorld

v0.1.4
+ Increased water to 4 wide so pumps display correctly
+ Added message when alens are destroyed

v0.1.3
+ Remove aliens with every teleport

v0.1.2
+ Added control button to open city list
+ (no longer opens city list automatically at spawn / join)
+ Build city list from mod settings.lua
+ Added city list to settings.lua
+ Changed teleport to use {} (absolute vs relative)
+ Added icon for control button
+ Added error info check if factorio world initial spawn does not match expected cities of earth initial spawn
+ Split out data & gui from control
+ Added telport wobble to reduce spawn-inside-player conflict
+ Added remove aliens
+ increased chunk gen area from 2 to 6

v0.1.1
+ moved internal city list
+ Added resource creation at each spawn on first teleport

## Helpful commands:
### Charting
* chart around player for 500
+ /c local plr = game.player; local pos = plr.position; local rad=500; plr.force.chart(plr.surface, {{x = pos.x-rad, y = pos.y-rad}, {x = pos.x+rad, y = pos.y+rad}});

+ /c game.player.surface.always_day=true

### Players
* get player index based on name: ( /*player_index*/ == hyspeed --> 1  )
+ /c for k, v in pairs(game.players) do game.player.print(v.name .. " --> " .. k) end

* get player's current position
+ /c local p = game.player.position; game.print( p.x..","..p.y)

* teleport player id to a location:
+ /c game.players[X].teleport({0,0})

### Speed
* speed up the game for mapping and moving during testing
+ /c game.speed=10

### Items
* add items to the player's inventory:
+ /c game.player.insert{ name="grenade", count=10}
+ /c game.player.insert{ name="offshore-pump", count=1}

### Teams
--Creates the force "Name"
+ /c game.create_force("Name")

--Sets this player to the new force
+ /c game.players["Player_name"].force = game.forces["Name"]

--Sets the new force ceasefire to the "other force"
+ /c game.forces["Name"].set_cease_fire("Other_force_name", true)

--Sets the spawn position of the force
+ /c game.forces["Name"].set_spawn_position({x = 10, y = 20}, game.surfaces[1])

--Prints the number of forces
+ /c game.print(#game.forces)

--Prints the name of all the forces
+ /c for name, force in pairs (game.forces) do  game.print(name) end
