-- Wibar
local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')

local defaults = {}
defaults.position = 'top'
defaults.height = 24

local function wibar(s, args)
    args = args or {}
    local position = args.position or defaults.position
    local height = args.height or defaults.height

    -- Import widgets
    local launcher = require 'widgets.wibar.launcher' (args)
    local taglist = require 'widgets.wibar.taglist' (s, args)
    local layout = require 'widgets.wibar.layout' (s, args)
    local prompt = require 'widgets.wibar.prompt' (s, args)

    local tasklist = require 'widgets.wibar.tasklist' (s, args)

    --local keyboard = require 'widgets.wibar.keyboard' (args)
    local systray = require 'widgets.wibar.systray' (s, args)
    local clock = require 'widgets.wibar.clock' (args)
    local session = require 'widgets.wibar.session' (args)

    local widget = awful.wibar {
        screen       = s,
        position     = position,
        height       = height,
        border_width = theme.border_width,
        border_color = theme.wibar_bg,
        opacity      = theme.opacity,
        widget   = {
            {
                { -- Left side
                    launcher,
                    taglist,
                    layout,
                    prompt,
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(4),
                },
                { -- Middle
                    {
                        tasklist,
                        layout = wibox.layout.align.horizontal,
                        fill_space = false,
                    },
                    widget = wibox.container.margin,
                    left = dpi(1),
                    right = dpi(4),
                },
                { -- Right side
                    --keyboard,
                    systray,
                    clock,
                    session,
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(4),
                },
                layout = wibox.layout.align.horizontal,
                spacing = dpi(0),
            },
            widget = wibox.container.margin,
            margins = dpi(2),
        }
    }

    return widget
end

return wibar
