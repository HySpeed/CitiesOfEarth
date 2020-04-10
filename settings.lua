local mod = "coe_"
local n = "n_"
local x = "x_"
local y = "y_"

data:extend({
--
  { type = "bool-setting",   name = mod .. "teams",   setting_type = "runtime-global", default_value =          true, order = "aa" },
--
  { type = "int-setting",    name = mod .. "spawn-x", setting_type = "runtime-global", default_value =          2160, order = "ab" },
  { type = "int-setting",    name = mod .. "spawn-y", setting_type = "runtime-global", default_value =           960, order = "ac" },
--
  { type = "string-setting", name = mod .. n .. "A",  setting_type = "runtime-global", default_value =       "Lagos", order = "an" },
  { type = "int-setting",    name = mod .. x .. "A",  setting_type = "runtime-global", default_value =             0, order = "ax" },
  { type = "int-setting",    name = mod .. y .. "A",  setting_type = "runtime-global", default_value =             0, order = "ay" },
--
  { type = "string-setting", name = mod .. n .. "B",  setting_type = "runtime-global", default_value =     "Beijing", order = "bn" },
  { type = "int-setting",    name = mod .. x .. "B",  setting_type = "runtime-global", default_value =          1150, order = "bx" },
  { type = "int-setting",    name = mod .. y .. "B",  setting_type = "runtime-global", default_value =          -430, order = "by" },
--
  { type = "string-setting", name = mod .. n .. "C",  setting_type = "runtime-global", default_value =       "Cairo", order = "cn" },
  { type = "int-setting",    name = mod .. x .. "C",  setting_type = "runtime-global", default_value =           190, order = "cx" },
  { type = "int-setting",    name = mod .. y .. "C",  setting_type = "runtime-global", default_value =          -290, order = "cy" },
--
  { type = "string-setting", name = mod .. n .. "D",  setting_type = "runtime-global", default_value =       "Delhi", order = "dn" },
  { type = "int-setting",    name = mod .. x .. "D",  setting_type = "runtime-global", default_value =           720, order = "dx" },
  { type = "int-setting",    name = mod .. y .. "D",  setting_type = "runtime-global", default_value =          -300, order = "dy" },
--
  { type = "string-setting", name = mod .. n .. "E",  setting_type = "runtime-global", default_value =    "Edmonton", order = "en" },
  { type = "int-setting",    name = mod .. x .. "E",  setting_type = "runtime-global", default_value =         -1500, order = "ex" },
  { type = "int-setting",    name = mod .. y .. "E",  setting_type = "runtime-global", default_value =          -650, order = "ey" },
--
  { type = "string-setting", name = mod .. n .. "F",  setting_type = "runtime-global", default_value = "Los Angeles", order = "fn" },
  { type = "int-setting",    name = mod .. x .. "F",  setting_type = "runtime-global", default_value =         -1500, order = "fx" },
  { type = "int-setting",    name = mod .. y .. "F",  setting_type = "runtime-global", default_value =          -450, order = "fy" },
--
  { type = "string-setting", name = mod .. n .. "G",  setting_type = "runtime-global", default_value =        "Omsk", order = "gn" },
  { type = "int-setting",    name = mod .. x .. "G",  setting_type = "runtime-global", default_value =          1000, order = "gx" },
  { type = "int-setting",    name = mod .. y .. "G",  setting_type = "runtime-global", default_value =          -700, order = "gy" },
--
  { type = "string-setting", name = mod .. n .. "H",  setting_type = "runtime-global", default_value = "Mexico City", order = "hn" },
  { type = "int-setting",    name = mod .. x .. "H",  setting_type = "runtime-global", default_value =         -1280, order = "hx" },
  { type = "int-setting",    name = mod .. y .. "H",  setting_type = "runtime-global", default_value =          -220, order = "hy" },
--                                                   
  { type = "string-setting", name = mod .. n .. "I",  setting_type = "runtime-global", default_value =      "Moscow", order = "in" },
  { type = "int-setting",    name = mod .. x .. "I",  setting_type = "runtime-global", default_value =           330, order = "ix" },
  { type = "int-setting",    name = mod .. y .. "I",  setting_type = "runtime-global", default_value =          -650, order = "iy" },
--                                                   
  { type = "string-setting", name = mod .. n .. "J",  setting_type = "runtime-global", default_value =    "New York", order = "jn" },
  { type = "int-setting",    name = mod .. x .. "J",  setting_type = "runtime-global", default_value =         -1050, order = "jx" },
  { type = "int-setting",    name = mod .. y .. "J",  setting_type = "runtime-global", default_value =          -400, order = "jy" },
--                                                   
  { type = "string-setting", name = mod .. n .. "K",  setting_type = "runtime-global", default_value =       "Paris", order = "kn" },
  { type = "int-setting",    name = mod .. x .. "K",  setting_type = "runtime-global", default_value =          -100, order = "kx" },
  { type = "int-setting",    name = mod .. y .. "K",  setting_type = "runtime-global", default_value =          -500, order = "ky" },
--                                                   
  { type = "string-setting", name = mod .. n .. "L",  setting_type = "runtime-global", default_value =   "Sao Paulo", order = "ln" },
  { type = "int-setting",    name = mod .. x .. "L",  setting_type = "runtime-global", default_value =          -650, order = "lx" },
  { type = "int-setting",    name = mod .. y .. "L",  setting_type = "runtime-global", default_value =           180, order = "ly" },
--                                                   
  { type = "string-setting", name = mod .. n .. "M",  setting_type = "runtime-global", default_value =      "Sydney", order = "mn" },
  { type = "int-setting",    name = mod .. x .. "M",  setting_type = "runtime-global", default_value =          1500, order = "mx" },
  { type = "int-setting",    name = mod .. y .. "M",  setting_type = "runtime-global", default_value =           400, order = "my" },
--
  { type = "string-setting", name = mod .. n .. "N",  setting_type = "runtime-global", default_value =           "N", order = "nn" },
  { type = "int-setting",    name = mod .. x .. "N",  setting_type = "runtime-global", default_value =             0, order = "nx" },
  { type = "int-setting",    name = mod .. y .. "N",  setting_type = "runtime-global", default_value =             0, order = "ny" },
--                                                   
  { type = "string-setting", name = mod .. n .. "O",  setting_type = "runtime-global", default_value =           "O", order = "on" },
  { type = "int-setting",    name = mod .. x .. "O",  setting_type = "runtime-global", default_value =             0, order = "ox" },
  { type = "int-setting",    name = mod .. y .. "O",  setting_type = "runtime-global", default_value =             0, order = "oy" },
--                                                                                                              
  { type = "string-setting", name = mod .. n .. "P",  setting_type = "runtime-global", default_value =           "P", order = "pn" },
  { type = "int-setting",    name = mod .. x .. "P",  setting_type = "runtime-global", default_value =             0, order = "px" },
  { type = "int-setting",    name = mod .. y .. "P",  setting_type = "runtime-global", default_value =             0, order = "py" },
--                                                                                                              
  { type = "string-setting", name = mod .. n .. "Q",  setting_type = "runtime-global", default_value =           "Q", order = "qn" },
  { type = "int-setting",    name = mod .. x .. "Q",  setting_type = "runtime-global", default_value =             0, order = "qx" },
  { type = "int-setting",    name = mod .. y .. "Q",  setting_type = "runtime-global", default_value =             0, order = "qy" },
--                                                                                                              
  { type = "string-setting", name = mod .. n .. "R",  setting_type = "runtime-global", default_value =           "R", order = "rn" },
  { type = "int-setting",    name = mod .. x .. "R",  setting_type = "runtime-global", default_value =             0, order = "rx" },
  { type = "int-setting",    name = mod .. y .. "R",  setting_type = "runtime-global", default_value =             0, order = "ry" },
--                                                                                                              
  { type = "string-setting", name = mod .. n .. "S",  setting_type = "runtime-global", default_value =           "S", order = "sn" },
  { type = "int-setting",    name = mod .. x .. "S",  setting_type = "runtime-global", default_value =             0, order = "sx" },
  { type = "int-setting",    name = mod .. y .. "S",  setting_type = "runtime-global", default_value =             0, order = "sy" },
--                                                                                                              
  { type = "string-setting", name = mod .. n .. "T",  setting_type = "runtime-global", default_value =           "T", order = "tn" },
  { type = "int-setting",    name = mod .. x .. "T",  setting_type = "runtime-global", default_value =             0, order = "tx" },
  { type = "int-setting",    name = mod .. y .. "T",  setting_type = "runtime-global", default_value =             0, order = "ty" },
--                                                                                                              
  { type = "string-setting", name = mod .. n .. "U",  setting_type = "runtime-global", default_value =           "U", order = "un" },
  { type = "int-setting",    name = mod .. x .. "U",  setting_type = "runtime-global", default_value =             0, order = "ux" },
  { type = "int-setting",    name = mod .. y .. "U",  setting_type = "runtime-global", default_value =             0, order = "uy" },
--                                                                                                              
  { type = "string-setting", name = mod .. n .. "V",  setting_type = "runtime-global", default_value =           "V", order = "vn" },
  { type = "int-setting",    name = mod .. x .. "V",  setting_type = "runtime-global", default_value =             0, order = "vx" },
  { type = "int-setting",    name = mod .. y .. "V",  setting_type = "runtime-global", default_value =             0, order = "vy" },
--                                                                                                              
  { type = "string-setting", name = mod .. n .. "W",  setting_type = "runtime-global", default_value =           "W", order = "wn" },
  { type = "int-setting",    name = mod .. x .. "W",  setting_type = "runtime-global", default_value =             0, order = "wx" },
  { type = "int-setting",    name = mod .. y .. "W",  setting_type = "runtime-global", default_value =             0, order = "wy" },
--                                                                                                              
  { type = "string-setting", name = mod .. n .. "X",  setting_type = "runtime-global", default_value =           "X", order = "xn" },
  { type = "int-setting",    name = mod .. x .. "X",  setting_type = "runtime-global", default_value =             0, order = "xx" },
  { type = "int-setting",    name = mod .. y .. "X",  setting_type = "runtime-global", default_value =             0, order = "xy" },
--                                                                                                              
  { type = "string-setting", name = mod .. n .. "Y",  setting_type = "runtime-global", default_value =           "Y", order = "yn" },
  { type = "int-setting",    name = mod .. x .. "Y",  setting_type = "runtime-global", default_value =             0, order = "yx" },
  { type = "int-setting",    name = mod .. y .. "Y",  setting_type = "runtime-global", default_value =             0, order = "yy" },
--                                                                                                              
  { type = "string-setting", name = mod .. n .. "Z",  setting_type = "runtime-global", default_value =           "Z", order = "zn" },
  { type = "int-setting",    name = mod .. x .. "Z",  setting_type = "runtime-global", default_value =             0, order = "zx" },
  { type = "int-setting",    name = mod .. y .. "Z",  setting_type = "runtime-global", default_value =             0, order = "zy" }
})

  