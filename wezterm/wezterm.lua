local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme_dirs = { "$HOME/.config/wezterm/colors/" }
config.color_scheme = "Peppermint"
config.hide_tab_bar_if_only_one_tab = true

return config
