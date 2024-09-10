local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.enable_tab_bar = false
config.window_padding = {
	left = 8,
	right = 8,
	top = 2,
	bottom = 2,
}
config.font = wezterm.font("Hack")
config.font_size = 11
config.colors = {
	background = "#1d1d1c",
	cursor_bg = "white",
	cursor_border = "white",
}

return config
