-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.font = wezterm.font_with_fallback {
    'ComicCode Nerd Font',
    'Nerd Font Symbols',
    'Noto Color Emoji'
}
config.font_size = 20
local my_scheme = wezterm.color.get_builtin_schemes()['Monokai Pro (Gogh)']
my_scheme.background = "#002B36"
my_scheme.tab_bar = {
    background = "#073642",
    active_tab = {
        bg_color = "#002B36",
        fg_color = "white",
        intensity = 'Bold',
    },
    inactive_tab = {
        bg_color = "#073642",
        fg_color = "white",
        intensity = 'Half',
    },
    new_tab = {
        bg_color = "#002B36",
        fg_color = "white",
        intensity = 'Bold',
    },


}

config.color_schemes = { ['My Scheme'] = my_scheme }
config.color_scheme = 'My Scheme'
config.default_cursor_style = 'BlinkingUnderline'

local mux = wezterm.mux

wezterm.on('gui-startup', function()
 local tab, pane, window = mux.spawn_window({})
 window:gui_window():maximize()
 window:set_title 'Terminal'
end)

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  return 'Terminal'
end)
config.use_fancy_tab_bar = false

config.keys = {
  {
    key = 'RightArrow',
    mods = 'ALT|SHIFT',
    action = wezterm.action.ActivateTabRelative(1)
  },
  {
    key = 'LeftArrow',
    mods = 'ALT|SHIFT',
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = '+',
    mods = 'ALT|SHIFT',
    action = wezterm.action.SpawnTab 'DefaultDomain'
  },
}


-- and finally, return the configuration to wezterm
return config

