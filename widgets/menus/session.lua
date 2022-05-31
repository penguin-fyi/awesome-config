local awful = require('awful')
local spawn = awful.spawn
local theme = require('beautiful')
local join = require('gears.table').join
local lookup_icon = require('utils.icon_finder').lookup

local click_to_hide = require('utils.click_to_hide').menu

local default_apps = {
    lock = 'light-locker-command -l',
    exit = 'awesome-client \'awesome.quit()\'',
    reboot = 'systemctl reboot',
    suspend = 'systemctl suspend',
    poweroff = 'systemctl poweroff',
}
local user_apps = require('config.apps')
local apps = join(default_apps, user_apps)

theme.session_lock_icon = lookup_icon(theme.session_lock_icon)
theme.session_exit_icon = lookup_icon(theme.session_exit_icon)
theme.session_reboot_icon = lookup_icon(theme.session_reboot_icon)
theme.session_suspend_icon = lookup_icon(theme.session_suspend_icon)
theme.session_poweroff_icon = lookup_icon(theme.session_poweroff_icon)

local session_menu = awful.menu({
    {
        '&Lock Desktop',
        function() spawn(apps.lock) end,
        theme.session_lock_icon
    },
    {
        '&Exit Desktop',
        function()
            awful.screen.focused().session.action = {
                cmd = apps.exit,
                message = 'Exit Desktop',
                icon = theme.session_exit_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        theme.session_exit_icon,
    },
    {
        '&Reboot System',
        function()
            awful.screen.focused().session.action = {
                cmd = apps.reboot,
                message = 'Reboot System',
                icon = theme.session_reboot_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        theme.session_reboot_icon
    },
    {
        '&Suspend System',
        function()
            awful.screen.focused().session.action = {
                cmd = apps.suspend,
                message = 'Suspend System',
                icon = theme.session_suspend_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        theme.session_suspend_icon
    },
    {
        '&Power Off',
        function()
            awful.screen.focused().session.action = {
                cmd = apps.poweroff,
                message = 'Power Off',
                icon = theme.session_poweroff_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        theme.session_poweroff_icon
    },
})

click_to_hide(session_menu)

return session_menu
