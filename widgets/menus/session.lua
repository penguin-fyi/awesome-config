local awful = require('awful')
local spawn = awful.spawn
local theme = require('beautiful')
local lookup_icon = require('menubar.utils').lookup_icon

local click_to_hide = require('utils.click_to_hide').menu

local apps = require('config.apps')

theme.session_lock_icon = lookup_icon(theme.session_lock_icon)
theme.session_exit_icon = lookup_icon(theme.session_exit_icon)
theme.session_reboot_icon = lookup_icon(theme.session_reboot_icon)
theme.session_suspend_icon = lookup_icon(theme.session_suspend_icon)
theme.session_poweroff_icon = lookup_icon(theme.session_poweroff_icon)

local session_menu = awful.menu({
    {
        '&Lock Desktop',
        function() spawn(apps.session_lock) end,
        theme.session_lock_icon
    },
    {
        '&Exit Desktop',
        function()
            _G.session_action = {
                cmd = apps.session_exit,
                text = 'Exit Desktop',
                icon = theme.session_exit_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        theme.session_exit_icon,
    },
    {
        '&Reboot System',
        function()
            _G.session_action = {
                cmd = apps.session_reboot,
                text = 'Reboot System',
                icon = theme.session_reboot_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        theme.session_reboot_icon
    },
    {
        '&Suspend System',
        function()
            _G.session_action = {
                cmd = apps.session_suspend,
                text = 'Suspend System',
                icon = theme.session_suspend_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        theme.session_suspend_icon
    },
    {
        '&Power Off',
        function()
            _G.session_action = {
                cmd = apps.session_poweroff,
                text = 'Power Off',
                icon = theme.session_poweroff_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        theme.session_poweroff_icon
    },
})

click_to_hide(session_menu)

return session_menu
