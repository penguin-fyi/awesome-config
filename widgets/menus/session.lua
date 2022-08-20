local awful     = require 'awful'
local spawn     = awful.spawn
local beautiful = require 'beautiful'
local find_icon = require 'utils.icon_finder'.lookup

local click_to_hide = require 'utils.click_to_hide'.menu

local cfg = require 'config'

local session_lock_icon = find_icon(beautiful.session_lock_icon)
local session_exit_icon = find_icon(beautiful.session_exit_icon)
local session_reboot_icon = find_icon(beautiful.session_reboot_icon)
local session_suspend_icon = find_icon(beautiful.session_suspend_icon)
local session_poweroff_icon = find_icon(beautiful.session_poweroff_icon)

local session_menu = awful.menu({
    {
        '&Lock Desktop',
        function() spawn(cfg.apps.lock) end,
        session_lock_icon
    },
    {
        '&Exit Desktop',
        function()
            awful.screen.focused().session.action = {
                cmd = cfg.apps.exit,
                message = 'Exit Desktop',
                icon = session_exit_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        session_exit_icon,
    },
    {
        '&Reboot System',
        function()
            awful.screen.focused().session.action = {
                cmd = cfg.apps.reboot,
                message = 'Reboot System',
                icon = session_reboot_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        session_reboot_icon
    },
    {
        '&Suspend System',
        function()
            awful.screen.focused().session.action = {
                cmd = cfg.apps.suspend,
                message = 'Suspend System',
                icon = session_suspend_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        session_suspend_icon
    },
    {
        '&Power Off',
        function()
            awful.screen.focused().session.action = {
                cmd = cfg.apps.poweroff,
                message = 'Power Off',
                icon = session_poweroff_icon
            }
            awesome.emit_signal('session::confirm:show')
        end,
        session_poweroff_icon
    },
})

click_to_hide(session_menu)

return session_menu
