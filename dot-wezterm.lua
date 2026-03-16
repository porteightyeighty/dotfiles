local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- config here
--
config.color_scheme = "iTerm2 Solarized Light"
config.enable_tab_bar = false
--
return config
