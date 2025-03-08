local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- config.color_scheme = 'Ayu Mirage'
-- config.color_scheme = 'Tango (base16)'
-- config.color_scheme = 'Galaxy'
config.color_scheme = 'Kanagawa'
-- testing www -> >= <= !=
config.font = wezterm.font {
    family = 'Intel One Mono',
    harfbuzz_features = { 'ss01', 'ss02' }
}
-- config.harfbuzz_features = { 'ss01', 'ss02' }
-- config.font = wezterm.font {
--     family = 'JetBrains Mono',
--     weight = 'Medium',
--     harfbuzz_features = { 'calt' },
-- }
config.font_size = 15
config.window_background_opacity = 0.8

return config
