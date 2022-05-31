-- Layout indicator
local awful = require 'awful'
local theme = require 'beautiful'
local dpi = theme.xresources.apply_dpi
local wibox = require 'wibox'

local container = require('widgets.buttons').wibar

local function layout(s, args)
    args = args or {}

    local mouse_buttons = {
        awful.button({ }, 1, function() awful.layout.inc( 1) end),
        awful.button({ }, 3, function() awful.layout.inc(-1) end),
        awful.button({ }, 4, function() awful.layout.inc(-1) end),
        awful.button({ }, 5, function() awful.layout.inc( 1) end),
    }

    local widget = wibox.widget {
        {
            {
                awful.widget.layoutbox {
                    screen  = s,
                    buttons = mouse_buttons,
                },
                widget = wibox.container.margin,
                margins = dpi(2),
            },
            widget = container,
        },
        widget = wibox.container.place,
    }

    return widget
end

return layout
