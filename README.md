# CitiesOfEarth
A Factorio mod that adds a city areas list to Factorio Earth

## Requirements
This mod requires Factorio Earth (v0.18+) and that the initial spawn point be in central Africa.  The city locations are based on a 0,0 point of 2160, 960.
**When first starting a new game, there will be a long delay while all cities are initialized.**

## Map Sizes
In order to prevent the map from wrapping, these are some world size limitations to use:

| Size | Scale  | Max X | Max Y | 
|-----:|:------:|------:|------:| 
|   1  | normal |  4000 |  1900 |
|   2  | normal |  8000 |  3800 |
|   4  | normal | 16000 |  7600 |
|   6  | normal | 24000 | 11000 |
|  10  | large  | 80000 | 38000 |

## **Initial Spawn Point**
You **must** set the spawn to these values in the mod settings for **Factorio Earth**!
* Spawn_X: 2160
* Spawn_Y:  960
* (Ebeiyin, Africa)

The game sets the rest of the map based on this.  Even though you 'spawn' in a lobby, the map is laid out based on this value as 0,0.    
This gives you the entire world while stopping you from creating another world.
Adjusting the spawn anywhere else cuts the other side of the world. Doing any part above / below the equator would also split the north / south

## Regions & Cities

| Region          | City         | X     | Y     |
|:----------------|:-------------|------:|------:|
| Africa          | Ebebiyin     |     0 |     0 |
| Africa          | Cairo        |   190 |  -290 |
| Africa          | Dakar        |  -300 |  -150 |
| Africa          | Johannesburg |   175 |   300 |
| Africa          | Oran         |  -175 |  -350 |
| Asia            | Beijing      |  1175 |  -450 |
| Asia            | Baoshan      |  1000 |  -233 |
| Asia            | Delhi        |   720 |  -300 |
| Asia            | Tbilisi      |   350 |  -425 |
| Canada          | Brisay       |  -950 |  -630 |
| Canada          | Saskatoon    | -1350 |  -575 |
| Central America | Mexico City  | -1280 |  -220 |
| Europe          | Oslo         |    -5 |  -675 |
| Europe          | Prague       |    15 |  -550 |
| Greenland       | Noord        |  -650 |  -750 |
| Middle East     | Riyadh       |   375 |  -225 |
| Oceana          | Sydney       |  1500 |   400 |
| Russia          | Anadyr       |  1500 |  -715 |
| Russia          | Aktobe       |   600 |  -550 |
| Russia          | Moscow       |   330 |  -650 |
| Russia          | Omsk         |  1000 |  -700 |
| South America   | Lima         | -1000 |    75 |
| South America   | Sao Paulo    |  -650 |   180 |
| United States   | Los Angeles  | -1500 |  -450 |
| United States   | New York     | -1050 |  -400 |
| United States   | Nome         | -1700 |  -700 |

Note: Enabling 'Large' map multiplies all values by 2.  This increases the detail of the base map.    

Region / City information was pulled from [Mapcarta](https://mapcarta.com/).


## To Do:
* none

## Known Issues:
* **You must delete mod-settings.dat for city changes to appear.**

v0.3.7
* Fixed typo in globals

v0.3.6
* Added concrete to spawn area to mark where a player may teleport into.
* Added option to not create starter resources at city.

v0.3.5
* Lobby Check Fix.

v0.3.4
* Changed Lobby name to prevent conflicts.

v0.3.3
* Changed UI on_click to resolve bug.

v0.3.2
* Adjusted cities - now at 26 cities with world-wide coverage.
* **You must delete mod-settings.dat for city changes to appear.**
  
v0.3.1
* Teams can be toggled in map setup (enable / disable).

v0.3.0
* Updated to Factorio 0.18
* Requires Factorio Earth (migrated from unsupported Factorio World)

v0.2.2
* Bug fix for water generation at city

v0.2.1
* Generate resources and clear biters in all cities at start of game.  This prevents delays when starting new cities.

v0.2.0
* Added teams - non hostile.

v0.1.9
* Updated to Factorio 0.17.

v0.1.8
* bug: Added checks for resources before attempting to create them.
* * This is to prevent errors with mods that remove or rename basic resources.  I will not adding support for alternate resources.

v0.1.7
* Added 'Teleport to Player' ability

v0.1.6
* Fixed version

v0.1.5
* Changed requirements to Factorio World 0.16.1

v0.1.4
* Increased water to 4 wide so pumps display correctly
* Added message when alens are destroyed

v0.1.3
* Remove aliens with every teleport

v0.1.2
* Added control button to open city list
* (no longer opens city list automatically at spawn / join)
* Build city list from settings.lua
* Added city list to settings.lua
* Changed teleport to use {} (absolute vs relative)
* Added icon for control button
* Added error info check if factorio world initial spawn does not match expected cities of earth initial spawn
* Split out data & gui from control
* Added telport wobble to reduce spawn-inside-player conflict
* Added remove aliens
* increased chunk gen area from 2 to 6

v0.1.1
* moved internal city list
* Added resource creation at each spawn on first teleport

## Helpful commands:
### Charting
* chart around player for 500
* /c local player = game.player; local pos = player.position; local rad=500; player.force.chart(player.surface, {{x = pos.x-rad, y = pos.y-rad}, {x = pos.x+rad, y = pos.y+rad}});
* /c game.player.surface.always_day=true
  Print the object 'area':
* /c game.print(serpent.block(event.area))

### Players
* get player index based on name: ( /*player_index*/ == hyspeed --> 1  )
* /c for k, v in pairs(game.players) do game.player.print(v.name .. " --> " .. k) end

* get player's current position
* /c local p = game.player.position; game.print( p.x..","..p.y)

* teleport player id to a location:
* /c game.players[X].teleport({0,0})

### Speed
* speed up the game for mapping and moving during testing
* /c game.speed=10

### Items
* add items to the player's inventory:
* /c game.player.insert{name="grenade", count=10}
* /c game.player.insert{name="car", count=1}
* /c game.player.insert{name="rocket-fuel", count=10}

### Teams
* Creates the force "Name"
* /c game.create_force("Name")

* Sets this player to the new force
* /c game.players["Player_name"].force = game.forces["Name"]

* Sets the new force ceasefire to the "other force"
* /c game.forces["Name"].set_cease_fire("Other_force_name", true)

* Sets the spawn position of the force
* /c game.forces["Name"].set_spawn_position({x = 10, y = 20}, game.surfaces[1])

* Prints the number of forces
* /c game.print(#game.forces)

* Prints the name of all the forces
* /c for name, force in pairs (game.forces) do  game.print(name) end
