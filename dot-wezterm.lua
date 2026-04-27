local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "iTerm2 Solarized Light"
config.enable_tab_bar = false

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false
return config
