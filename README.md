 # CitiesOfEarth
A Factorio mod that adds a city areas list to Factorio World (Earth)

This mod requires Factorio World (Earth) and that the initial spawn point be in west Africa.  The city locations are based on a 0,0 point of 2100,900.

In order to prevent the map from wrapping, these are some world size limitations to use:
+ Size: 1 - normal, Max X:  4000, Max Y:   1900
+ Size: 2 - normal, Max X:  8000, Max Y:   3800
+ Size: 6 - normal, Max X: 24000, Maxy Y: 11000
+ Size: 10 - large, Max X: 80000, Max Y:  38000
+ Spawn_X: 2160, Spawn_Y: 960

This gives you the entire world (at default scale of 6) while stopping you from creating another world
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


Helpful commands:
* chart around player for 500
+ /c local plr = game.player; local pos = plr.position; local rad=500; plr.force.chart(plr.surface, {{x = pos.x-rad, y = pos.y-rad}, {x = pos.x+rad, y = pos.y+rad}});

+ /c game.player.surface.always_day=true

* get player index based on name: ( /*player_index*/ == hyspeed --> 1  )
+ /c for k, v in pairs(game.players) do game.player.print(v.name .. " --> " .. k) end

* get player's current position
+ /c local p = game.player.position; game.print( p.x..","..p.y)

* teleport player id to a location:
+ /c game.players[X].teleport({0,0})

* speed up the game for mapping and moving during testing
+ /c game.speed=10
