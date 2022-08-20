local awful     = require 'awful'
local hotkeys   = require 'awful.hotkeys_popup'
local beautiful = require 'beautiful'
local spawn     = awful.spawn

local about_dlg = require 'widgets.about'
local find_icon = require 'utils.icon_finder'.lookup

local cfg = require 'config'

local awesome_about_icon   = find_icon(beautiful.awesome_about_icon)
local awesome_config_icon  = find_icon(beautiful.awesome_config_icon)
local awesome_manual_icon  = find_icon(beautiful.awesome_manual_icon)
local awesome_hotkeys_icon = find_icon(beautiful.awesome_hotkeys_icon)
local awesome_restart_icon = find_icon(beautiful.awesome_restart_icon)
local awesome_exit_icon    = find_icon(beautiful.awesome_exit_icon)

local awesome_menu = {
    {
        '&About Awesome',
        function()
            about_dlg()
        end,
        awesome_about_icon
    },
    {
        '&Show Hotkeys',
        function()
            hotkeys.show_help(nil, awful.screen.focused())
        end,
        awesome_hotkeys_icon
    },
    {
        'Read &Manual',
        function()
            spawn(cfg.apps.manual)
        end,
        awesome_manual_icon
    },
    {
        'Edit &Config',
        function()
            spawn(cfg.apps.config)
        end,
        awesome_config_icon
    },
    {
        '&Restart Awesome',
        function()
            spawn(cfg.apps.restart)
        end,
        awesome_restart_icon
    },
    {
        '&Exit Desktop',
        function()
            awful.screen.focused().session.action = {
                cmd = cfg.apps.exit,
                message = 'Exit Desktop',
                icon = awesome_exit_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        awesome_exit_icon
    },
}

return awesome_menu
