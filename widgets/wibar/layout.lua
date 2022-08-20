-- Layout indicator
local awful     = require 'awful'
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local container = require 'widgets.buttons'.wibar

local function layout(s, args)

    args = args or {}

    local mouse_buttons = {
        awful.button({ }, 1, function() awful.layout.inc( 1) end),
        awful.button({ }, 3, function() awful.layout.inc(-1) end),
        awful.button({ }, 4, function() awful.layout.inc(-1) end),
        awful.button({ }, 5, function() awful.layout.inc( 1) end),
    }

    local widget = wibox.widget {
        widget = wibox.container.place,
        {
            widget = container,
            {
                awful.widget.layoutbox {
                    screen  = s,
                    buttons = mouse_buttons,
                },
                widget = wibox.container.margin,
                margins = dpi(2),
            }
        }
    }

    return widget
end

return layout
