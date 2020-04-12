local mod = "coe_"
local n = "n_"
local x = "x_"
local y = "y_"

data:extend({
--
  { type = "bool-setting",   name = mod .. "teams",   setting_type = "runtime-global", default_value =           true, order = "aa" },
--
  { type = "int-setting",    name = mod .. "spawn-x", setting_type = "runtime-global", default_value =           2160, order = "ab" },
  { type = "int-setting",    name = mod .. "spawn-y", setting_type = "runtime-global", default_value =            960, order = "ac" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "A",  setting_type = "runtime-global", default_value =     "Ebebiyin", order = "an" },
  { type = "int-setting",    name = mod .. x .. "A",  setting_type = "runtime-global", default_value =              0, order = "ax" },
  { type = "int-setting",    name = mod .. y .. "A",  setting_type = "runtime-global", default_value =              0, order = "ay" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "B",  setting_type = "runtime-global", default_value =       "Aktobe", order = "bn" },
  { type = "int-setting",    name = mod .. x .. "B",  setting_type = "runtime-global", default_value =            600, order = "bx" },
  { type = "int-setting",    name = mod .. y .. "B",  setting_type = "runtime-global", default_value =           -550, order = "by" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "C",  setting_type = "runtime-global", default_value =       "Anadyr", order = "cn" },
  { type = "int-setting",    name = mod .. x .. "C",  setting_type = "runtime-global", default_value =           1500, order = "cx" },
  { type = "int-setting",    name = mod .. y .. "C",  setting_type = "runtime-global", default_value =           -715, order = "cy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "D",  setting_type = "runtime-global", default_value =      "Baoshan", order = "dn" },
  { type = "int-setting",    name = mod .. x .. "D",  setting_type = "runtime-global", default_value =           1000, order = "dx" },
  { type = "int-setting",    name = mod .. y .. "D",  setting_type = "runtime-global", default_value =           -233, order = "dy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "E",  setting_type = "runtime-global", default_value =      "Beijing", order = "en" },
  { type = "int-setting",    name = mod .. x .. "E",  setting_type = "runtime-global", default_value =           1175, order = "ex" },
  { type = "int-setting",    name = mod .. y .. "E",  setting_type = "runtime-global", default_value =           -450, order = "ey" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "F",  setting_type = "runtime-global", default_value =       "Brisay", order = "fn" },
  { type = "int-setting",    name = mod .. x .. "F",  setting_type = "runtime-global", default_value =           -950, order = "fx" },
  { type = "int-setting",    name = mod .. y .. "F",  setting_type = "runtime-global", default_value =           -630, order = "fy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "G",  setting_type = "runtime-global", default_value =        "Cairo", order = "gn" },
  { type = "int-setting",    name = mod .. x .. "G",  setting_type = "runtime-global", default_value =            190, order = "gx" },
  { type = "int-setting",    name = mod .. y .. "G",  setting_type = "runtime-global", default_value =           -290, order = "gy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "H",  setting_type = "runtime-global", default_value =        "Dakar", order = "hn" },
  { type = "int-setting",    name = mod .. x .. "H",  setting_type = "runtime-global", default_value =           -300, order = "hx" },
  { type = "int-setting",    name = mod .. y .. "H",  setting_type = "runtime-global", default_value =           -150, order = "hy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "I",  setting_type = "runtime-global", default_value =        "Delhi", order = "in" },
  { type = "int-setting",    name = mod .. x .. "I",  setting_type = "runtime-global", default_value =            720, order = "ix" },
  { type = "int-setting",    name = mod .. y .. "I",  setting_type = "runtime-global", default_value =           -300, order = "iy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "J",  setting_type = "runtime-global", default_value = "Johannesburg", order = "jn" },
  { type = "int-setting",    name = mod .. x .. "J",  setting_type = "runtime-global", default_value =            175, order = "jx" },
  { type = "int-setting",    name = mod .. y .. "J",  setting_type = "runtime-global", default_value =            300, order = "jy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "K",  setting_type = "runtime-global", default_value =          "Lima", order = "kn" },
  { type = "int-setting",    name = mod .. x .. "K",  setting_type = "runtime-global", default_value =           -1000, order = "kx" },
  { type = "int-setting",    name = mod .. y .. "K",  setting_type = "runtime-global", default_value =              75, order = "ky" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "L",  setting_type = "runtime-global", default_value =   "Los Angeles", order = "ln" },
  { type = "int-setting",    name = mod .. x .. "L",  setting_type = "runtime-global", default_value =           -1500, order = "lx" },
  { type = "int-setting",    name = mod .. y .. "L",  setting_type = "runtime-global", default_value =            -450, order = "ly" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "M",  setting_type = "runtime-global", default_value =   "Mexico City", order = "mn" },
  { type = "int-setting",    name = mod .. x .. "M",  setting_type = "runtime-global", default_value =           -1280, order = "mx" },
  { type = "int-setting",    name = mod .. y .. "M",  setting_type = "runtime-global", default_value =            -220, order = "my" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "N",  setting_type = "runtime-global", default_value =        "Moscow", order = "nn" },
  { type = "int-setting",    name = mod .. x .. "N",  setting_type = "runtime-global", default_value =             330, order = "nx" },
  { type = "int-setting",    name = mod .. y .. "N",  setting_type = "runtime-global", default_value =            -650, order = "ny" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "O",  setting_type = "runtime-global", default_value =      "New York", order = "on" },
  { type = "int-setting",    name = mod .. x .. "O",  setting_type = "runtime-global", default_value =           -1050, order = "ox" },
  { type = "int-setting",    name = mod .. y .. "O",  setting_type = "runtime-global", default_value =            -400, order = "oy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "P",  setting_type = "runtime-global", default_value =          "Nome", order = "pn" },
  { type = "int-setting",    name = mod .. x .. "P",  setting_type = "runtime-global", default_value =           -1700, order = "px" },
  { type = "int-setting",    name = mod .. y .. "P",  setting_type = "runtime-global", default_value =            -700, order = "py" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "Q",  setting_type = "runtime-global", default_value =          "Noord", order = "qn" },
  { type = "int-setting",    name = mod .. x .. "Q",  setting_type = "runtime-global", default_value =             -650, order = "qx" },
  { type = "int-setting",    name = mod .. y .. "Q",  setting_type = "runtime-global", default_value =             -750, order = "qy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "R",  setting_type = "runtime-global", default_value =           "Omsk", order = "rn" },
  { type = "int-setting",    name = mod .. x .. "R",  setting_type = "runtime-global", default_value =             1000, order = "rx" },
  { type = "int-setting",    name = mod .. y .. "R",  setting_type = "runtime-global", default_value =             -700, order = "ry" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "S",  setting_type = "runtime-global", default_value =           "Oran", order = "sn" },
  { type = "int-setting",    name = mod .. x .. "S",  setting_type = "runtime-global", default_value =             -175, order = "sx" },
  { type = "int-setting",    name = mod .. y .. "S",  setting_type = "runtime-global", default_value =             -350, order = "sy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "T",  setting_type = "runtime-global", default_value =           "Oslo", order = "tn" },
  { type = "int-setting",    name = mod .. x .. "T",  setting_type = "runtime-global", default_value =               -5, order = "tx" },
  { type = "int-setting",    name = mod .. y .. "T",  setting_type = "runtime-global", default_value =             -675, order = "ty" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "U",  setting_type = "runtime-global", default_value =         "Prague", order = "un" },
  { type = "int-setting",    name = mod .. x .. "U",  setting_type = "runtime-global", default_value =               15, order = "ux" },
  { type = "int-setting",    name = mod .. y .. "U",  setting_type = "runtime-global", default_value =             -550, order = "uy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "V",  setting_type = "runtime-global", default_value =         "Riyadh", order = "vn" },
  { type = "int-setting",    name = mod .. x .. "V",  setting_type = "runtime-global", default_value =              375, order = "vx" },
  { type = "int-setting",    name = mod .. y .. "V",  setting_type = "runtime-global", default_value =             -225, order = "vy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "W",  setting_type = "runtime-global", default_value =      "Sao Paulo", order = "wn" },
  { type = "int-setting",    name = mod .. x .. "W",  setting_type = "runtime-global", default_value =             -650, order = "wx" },
  { type = "int-setting",    name = mod .. y .. "W",  setting_type = "runtime-global", default_value =              180, order = "wy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "X",  setting_type = "runtime-global", default_value =      "Saskatoon", order = "xn" },
  { type = "int-setting",    name = mod .. x .. "X",  setting_type = "runtime-global", default_value =            -1350, order = "xx" },
  { type = "int-setting",    name = mod .. y .. "X",  setting_type = "runtime-global", default_value =             -575, order = "xy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "Y",  setting_type = "runtime-global", default_value =         "Sydney", order = "yn" },
  { type = "int-setting",    name = mod .. x .. "Y",  setting_type = "runtime-global", default_value =             1500, order = "yx" },
  { type = "int-setting",    name = mod .. y .. "Y",  setting_type = "runtime-global", default_value =              400, order = "yy" },
-- good location (0.3.2)
  { type = "string-setting", name = mod .. n .. "Z",  setting_type = "runtime-global", default_value =        "Tbilisi", order = "zn" },
  { type = "int-setting",    name = mod .. x .. "Z",  setting_type = "runtime-global", default_value =              350, order = "zx" },
  { type = "int-setting",    name = mod .. y .. "Z",  setting_type = "runtime-global", default_value =             -425, order = "zy" }
})
