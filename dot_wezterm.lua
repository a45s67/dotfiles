local wezterm = require 'wezterm'
local config = {}

-- # Set font and color scheme
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.window_background_opacity = 0.8
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

-- How to custom color scheme: [catppuccin/wezterm: :shell: Soothing pastel theme for WezTerm](https://github.com/catppuccin/wezterm)
local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#000000"
config.color_schemes = {
    ["OLEDppuccin"] = custom,
}
config.color_scheme = "OLEDppuccin"

function MapCmdToCtrl(config_keys)

    local act = wezterm.action
    -- [add ability to remap modifier and caps lock keys · Issue #1777 · wez/wezterm](https://github.com/wez/wezterm/issues/1777)
    -- Map Cmd -> Ctrl
    for i = 91, 126 do
        local key = string.char(i)
        second_mods = ""
        for from_first_mods, to_first_mods in pairs({ SUPER = "CTRL" }) do
            from_mods = from_first_mods .. second_mods
            to_mods = to_first_mods .. second_mods
            table.insert(config_keys, {
                key = key,
                mods = from_mods,
                action = act.SendKey({
                    key = key,
                    mods = to_mods,
                }),
            })
        end
    end
end

-- # Remap keybindings
-- [PasteFrom - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/keyassignment/PasteFrom.html)
local act = wezterm.action
config.keys = {
    -- paste from the clipboard with CMD-SHIFT-v
    { key = 'V', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
    { key = 'T', mods = 'SUPER', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'W', mods = 'SUPER', action = act.CloseCurrentTab{ confirm = true } },
    { key = 'L', mods = 'SUPER', action = act.ShowTabNavigator },
}
MapCmdToCtrl(config.keys)

return config
