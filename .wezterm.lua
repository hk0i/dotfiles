local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- config.color_scheme = 'Ayu Mirage'
-- config.color_scheme = 'Tango (base16)'
-- config.color_scheme = 'Galaxy'
config.color_scheme = 'Kanagawa'
config.font = wezterm.font 'Intel One Mono'
config.font_size = 15

return config
