local awful = require('awful')
local spawn = awful.spawn
local mod = _G.cfg.modkey

spawn.easy_async_with_shell('command -v rofi', function(path)
    if not path then return end

    require('utils.rofi')()

    local cmd = { exe = 'rofi' }
    cmd.run = cmd.exe..' -show run'
    cmd.drun = cmd.exe..' -show drun'
    cmd.window = cmd.exe..' -show window'
    cmd.pass = 'rofi-pass'

    local keys = {
        awful.key({ mod.super            }, "space", function () awful.spawn(cmd.drun) end,
                  {description = "application search", group = "external"}),
        awful.key({ mod.super, mod.alt   }, "r", function () awful.spawn(cmd.run) end,
                  {description = "command search", group = "external"}),
        awful.key({ mod.super, mod.alt   }, "Tab", function () awful.spawn(cmd.window) end,
                  {description = "window search", group = "external"}),
        awful.key({ mod.super, mod.alt   }, "p", function () awful.spawn(cmd.pass) end,
                  {description = "password search", group = "external"}),
    }

    awful.keyboard.append_global_keybindings(keys)
end)


spawn.easy_async_with_shell('command -v pactl', function(path)
    if not path then return end

    local cmd = { exe = 'pactl' }
    cmd.inc = cmd.exe..' set-sink-volume @DEFAULT_SINK@ +5%'
    cmd.dec = cmd.exe..' set-sink-volume @DEFAULT_SINK@ -5%'
    cmd.mute = cmd.exe..' set-sink-mute @DEFAULT_SINK@ toggle'

    local keys = {
        awful.key({ }, 'XF86AudioRaiseVolume', function() spawn(cmd.inc, false) end,
                  {description = 'raise volume', group = 'external'}),
        awful.key({ }, 'XF86AudioLowerVolume', function() spawn(cmd.dec, false) end,
                  {description = 'lower volume', group = 'external'}),
        awful.key({ }, 'XF86AudioMute', function() spawn(cmd.mute, false) end,
                  {description = 'toggle mute', group = 'external'}),
    }

    awful.keyboard.append_global_keybindings(keys)
end)

spawn.easy_async_with_shell('command -v playerctl', function(path)
    if not path then return end

    local cmd = { exe = 'playerctl' }
    cmd.play = cmd.exe..' play-pause'
    cmd.next = cmd.exe..' next'
    cmd.prev = cmd.exe..' previous'
    cmd.stop = cmd.exe..' stop'

    local keys = {
        awful.key({ }, 'XF86AudioPlay', function() spawn(cmd.play, false) end,
                  {description = 'toggle play and pause', group = 'external'}),
        awful.key({ }, 'XF86AudioNext', function() spawn(cmd.next, false) end,
                  {description = 'go to next track', group = 'external'}),
        awful.key({ }, 'XF86AudioPrev', function() spawn(cmd.prev, false) end,
                  {description = 'go to previous track', group = 'external'}),
        awful.key({ }, 'XF86AudioStop', function() spawn(cmd.stop, false) end,
                  {description = 'stop playback', group = 'external'}),
    }
    awful.keyboard.append_global_keybindings(keys)
end)

spawn.easy_async_with_shell('command -v xbacklight', function(path)
    if not path then return end

    local cmd = { exe = 'xbacklight' }
    cmd.inc = cmd.exe..' -inc 10%'
    cmd.dec = cmd.exe..' -dec 10%'

    local keys = {
        awful.key({ }, 'XF86MonBrightnessUp', function() spawn(cmd.inc, false) end,
                  {description = 'increase backlight brightness', group = 'external'}),
        awful.key({ }, 'XF86MonBrightnessDown', function() spawn(cmd.dec, false) end,
                  {description = 'decrease backlight brightness', group = 'external'}),
    }

    awful.keyboard.append_global_keybindings(keys)
end)

spawn.easy_async_with_shell('command -v touchpad', function(path)
    if not path then return end

    local cmd = { exe = 'touchpad-toggle' }

    local keys = {
        awful.key({ mod.super, mod.alt }, 't', function() spawn(cmd.exe, false) end,
                  {description = 'toggle touchpad input', group = 'external'}),
    }

    awful.keyboard.append_global_keybindings(keys)
end)
