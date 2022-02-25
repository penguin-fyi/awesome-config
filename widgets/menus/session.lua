-- Awesome
local awful = require('awful')
local spawn = awful.spawn
local theme = require('beautiful')
local lookup_icon = require('menubar.utils').lookup_icon

-- Custom
local cfg_apps = _G.cfg.apps or nil

-- Local
local apps = {}
apps.lock = cfg_apps.session_lock or 'light-locker-command -l'
apps.exit = cfg_apps.session_exit or 'awesome-client \'awesome.quit()\''
apps.reboot = cfg_apps.session_reboot or 'systemctl reboot'
apps.suspend = cfg_apps.session_suspend or 'systemctl suspend'
apps.poweroff = cfg_apps.session_poweroff or 'systemctl poweroff'

local icons = {}
icons.lock = lookup_icon('xfce-system-lock') or theme.session_lock_icon
icons.exit = lookup_icon('xfsm-logout') or theme.session_exit_icon
icons.reboot = lookup_icon('xfsm-reboot') or theme.session_reboot_icon
icons.suspend = lookup_icon('xfsm-suspend') or theme.session_suspend_icon
icons.poweroff = lookup_icon('xfsm-shutdown') or theme.session_poweroff_icon

local _M = function()

    return awful.menu({
        {
            '&Lock Desktop',
            function()
                spawn(apps.lock)
            end,
            icons.lock
        },
        {
            '&Exit Desktop',
            function()
                _G.session.cmd = apps.exit
                _G.session.text = 'Exit Desktop'
                _G.session.icon = icons.exit
                awesome.emit_signal('session::confirm:show')
            end,
            icons.exit,
        },
        {
            '&Reboot System',
            function()
                _G.session.cmd = apps.reboot
                _G.session.text = 'Reboot System'
                _G.session.icon = icons.reboot
                awesome.emit_signal('session::confirm:show')
            end,
            icons.reboot
        },
        {
            '&Suspend System',
            function()
                _G.session.cmd = apps.suspend
                _G.session.text = 'Suspend System'
                _G.session.icon = icons.suspend
                awesome.emit_signal('session::confirm:show')
            end,
            icons.suspend
        },
        {
            '&Power Off',
            function()
                _G.session.cmd = apps.poweroff
                _G.session.text = 'Power Off'
                _G.session.icon = icons.poweroff
                awesome.emit_signal('session::confirm:show')
            end,
            icons.poweroff
        },
    })

end

return _M
