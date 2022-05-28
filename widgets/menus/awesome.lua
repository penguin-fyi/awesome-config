local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
local spawn = awful.spawn
local theme = require('beautiful')
local join = require('gears.table').join
local lookup_icon = require('utils.icon_finder').lookup

local default_apps = {
    config = 'xdg-open '..awesome.conffile,
    manual = 'xterm -e man awesome',
    restart = 'awesome-client \'awesome.restart()\'',
    exit = 'awesome-client \'awesome.quit()\'',
}
local user_apps = require('config.apps')
local apps = join(default_apps, user_apps)

theme.awesome_about_icon = lookup_icon(theme.awesome_about_icon)
theme.awesome_config_icon = lookup_icon(theme.awesome_config_icon)
theme.awesome_manual_icon = lookup_icon(theme.awesome_manual_icon)
theme.awesome_hotkeys_icon = lookup_icon(theme.awesome_hotkeys_icon)
theme.awesome_restart_icon = lookup_icon(theme.awesome_restart_icon)
theme.awesome_exit_icon = lookup_icon(theme.awesome_exit_icon)

local awesome_menu = {
    {
        '&About Awesome',
        function() require('widgets.about')() end,
        theme.awesome_about_icon
    },
    {
        '&Show Hotkeys',
        function() hotkeys_popup.show_help(nil, awful.screen.focused()) end,
        theme.awesome_hotkeys_icon
    },
    {
        'Read &Manual',
        function() spawn(apps.manual) end,
        theme.awesome_manual_icon
    },
    {
        'Edit &Config',
        function() spawn(apps.config) end,
        theme.awesome_config_icon
    },
    {
        '&Restart Awesome',
        function() spawn(apps.restart) end,
        theme.awesome_restart_icon
    },
    {
        '&Exit Desktop',
        function()
            _G.session_action = {
                cmd = apps.exit,
                text = 'Exit Desktop',
                icon = theme.awesome_exit_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        theme.awesome_exit_icon
    },
}

return awesome_menu
