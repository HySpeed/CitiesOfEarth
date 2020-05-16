local mod = "coe_"
local n = "n_"
local x = "x_"
local y = "y_"

-- This file has only 5 cities - for rapid testing

data:extend({
--
  { type = "bool-setting",   name = mod .. "teams",   setting_type = "runtime-global", default_value =           true, order = "aa" },
  { type = "bool-setting",   name = mod .. "create",  setting_type = "runtime-global", default_value =           true, order = "ab" },
--
  { type = "int-setting",    name = mod .. "spawn-x", setting_type = "runtime-global", default_value =           2160, order = "ae" },
  { type = "int-setting",    name = mod .. "spawn-y", setting_type = "runtime-global", default_value =            960, order = "af" },
--
  { type = "string-setting", name = mod .. n .. "A",  setting_type = "runtime-global", default_value =     "Ebebiyin", order = "an" },
  { type = "int-setting",    name = mod .. x .. "A",  setting_type = "runtime-global", default_value =              0, order = "ax" },
  { type = "int-setting",    name = mod .. y .. "A",  setting_type = "runtime-global", default_value =              0, order = "ay" },
--
  { type = "string-setting", name = mod .. n .. "B",  setting_type = "runtime-global", default_value =       "Aktobe", order = "bn" },
  { type = "int-setting",    name = mod .. x .. "B",  setting_type = "runtime-global", default_value =            600, order = "bx" },
  { type = "int-setting",    name = mod .. y .. "B",  setting_type = "runtime-global", default_value =           -550, order = "by" },
--
  { type = "string-setting", name = mod .. n .. "C",  setting_type = "runtime-global", default_value =       "Anadyr", order = "cn" },
  { type = "int-setting",    name = mod .. x .. "C",  setting_type = "runtime-global", default_value =           1500, order = "cx" },
  { type = "int-setting",    name = mod .. y .. "C",  setting_type = "runtime-global", default_value =           -715, order = "cy" },
--
  { type = "string-setting", name = mod .. n .. "D",  setting_type = "runtime-global", default_value =      "Baoshan", order = "dn" },
  { type = "int-setting",    name = mod .. x .. "D",  setting_type = "runtime-global", default_value =           1000, order = "dx" },
  { type = "int-setting",    name = mod .. y .. "D",  setting_type = "runtime-global", default_value =           -233, order = "dy" },
--
  { type = "string-setting", name = mod .. n .. "E",  setting_type = "runtime-global", default_value =      "Beijing", order = "en" },
  { type = "int-setting",    name = mod .. x .. "E",  setting_type = "runtime-global", default_value =           1175, order = "ex" },
  { type = "int-setting",    name = mod .. y .. "E",  setting_type = "runtime-global", default_value =           -450, order = "ey" }
})
