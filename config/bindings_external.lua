local awful     = require 'awful'
local key       = awful.key
local keyboard  = awful.keyboard
local spawn     = awful.spawn

local mod       = require 'config.modkeys'
local get_theme = require 'utils.theme_rofi'

local function init()

    --
    spawn.easy_async_with_shell('command -v rofi', function(path)
        if not path then return end

        get_theme()

        local cmd = { exe = 'rofi' }
        cmd.run = cmd.exe..' -show run'
        cmd.drun = cmd.exe..' -show drun'
        cmd.window = cmd.exe..' -show window'
        cmd.pass = 'rofi-pass'

        local keys = {
            key({ mod.super            }, 'space', function() spawn(cmd.drun) end,
                      {description = 'application search', group = 'external'}),
            key({ mod.super, mod.alt   }, 'r', function() spawn(cmd.run) end,
                      {description = 'command search', group = 'external'}),
            key({ mod.super, mod.alt   }, 'Tab', function() spawn(cmd.window) end,
                      {description = 'window search', group = 'external'}),
            key({ mod.super, mod.alt   }, 'p', function() spawn(cmd.pass) end,
                      {description = 'password search', group = 'external'}),
        }

        keyboard.append_global_keybindings(keys)
    end)

    --
    spawn.easy_async_with_shell('command -v pactl', function(path)
        if not path then return end

        local cmd = { exe = 'pactl' }
        cmd.inc = cmd.exe..' set-sink-volume @DEFAULT_SINK@ +5%'
        cmd.dec = cmd.exe..' set-sink-volume @DEFAULT_SINK@ -5%'
        cmd.mute = cmd.exe..' set-sink-mute @DEFAULT_SINK@ toggle'

        local keys = {
            key({ }, 'XF86AudioRaiseVolume', function() spawn(cmd.inc, false) end,
                      {description = 'raise volume', group = 'external'}),
            key({ }, 'XF86AudioLowerVolume', function() spawn(cmd.dec, false) end,
                      {description = 'lower volume', group = 'external'}),
            key({ }, 'XF86AudioMute', function() spawn(cmd.mute, false) end,
                      {description = 'toggle mute', group = 'external'}),
        }

        keyboard.append_global_keybindings(keys)
    end)

    --
    spawn.easy_async_with_shell('command -v playerctl', function(path)
        if not path then return end

        local cmd = { exe = 'playerctl' }
        cmd.play = cmd.exe..' play-pause'
        cmd.next = cmd.exe..' next'
        cmd.prev = cmd.exe..' previous'
        cmd.stop = cmd.exe..' stop'

        local keys = {
            key({ }, 'XF86AudioPlay', function() spawn(cmd.play, false) end,
                      {description = 'toggle play and pause', group = 'external'}),
            key({ }, 'XF86AudioNext', function() spawn(cmd.next, false) end,
                      {description = 'go to next track', group = 'external'}),
            key({ }, 'XF86AudioPrev', function() spawn(cmd.prev, false) end,
                      {description = 'go to previous track', group = 'external'}),
            key({ }, 'XF86AudioStop', function() spawn(cmd.stop, false) end,
                      {description = 'stop playback', group = 'external'}),
        }
        keyboard.append_global_keybindings(keys)
    end)

    --
    spawn.easy_async_with_shell('command -v xbacklight', function(path)
        if not path then return end

        local cmd = { exe = 'xbacklight' }
        cmd.inc = cmd.exe..' -inc 10%'
        cmd.dec = cmd.exe..' -dec 10%'

        local keys = {
            key({ }, 'XF86MonBrightnessUp', function() spawn(cmd.inc, false) end,
                      {description = 'increase backlight brightness', group = 'external'}),
            key({ }, 'XF86MonBrightnessDown', function() spawn(cmd.dec, false) end,
                      {description = 'decrease backlight brightness', group = 'external'}),
        }

        keyboard.append_global_keybindings(keys)
    end)

    --
    spawn.easy_async_with_shell('command -v touchpad', function(path)
        if not path then return end

        local cmd = { exe = 'touchpad-toggle' }

        local keys = {
            key({ mod.super, mod.alt }, 't', function() spawn(cmd.exe, false) end,
                      {description = 'toggle touchpad input', group = 'external'}),
        }

        keyboard.append_global_keybindings(keys)
    end)
end

return init
