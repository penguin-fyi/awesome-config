-- Awesome
local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
local spawn = awful.spawn
local theme = require('beautiful')
local lookup_icon = require('menubar.utils').lookup_icon

-- Custom
local cfg_apps = _G.cfg.apps or nil

-- Local
local apps = {}
apps.config = cfg_apps.awesome_menu_config or cfg_apps.editor_cmd..' '..awesome.conffile
apps.manual = cfg_apps.awesome_menu_manual or cfg_apps.terminal..' -e man awesome'
apps.restart = cfg_apps.awesome_menu_restart or 'awesome-client \'awesome.restart()\''
apps.exit = cfg_apps.awesome_menu_exit or 'awesome-client \'awesome.quit()\''

local icons = {}
icons.config = lookup_icon('systemsettings') or theme.awesome_config_icon
icons.manual = lookup_icon('system-help') or theme.awesome_manual_icon
icons.hotkeys = lookup_icon('key_bindings') or theme.awesome_hotkeys_icon
icons.restart = lookup_icon('system-restart') or theme.awesome_restart_icon
icons.exit = lookup_icon('system-log-out') or theme.awesome_exit_icon

local _M = {
    { '&Show Hotkeys',
        function()
           hotkeys_popup.show_help(nil, awful.screen.focused())
        end,
        icons.hotkeys
    },
    { 'Read &Manaul', function() spawn(apps.manual) end, icons.manual },
    { 'Edit &Config', function() spawn(apps.config) end, icons.config },
    { '&Restart Awesome', function() spawn(apps.restart) end, icons.restart },
    { '&Exit Awesome', function() spawn(apps.exit) end, icons.exit },
}

return _M
