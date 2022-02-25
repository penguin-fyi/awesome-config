local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')
local container = require('widgets.buttons').wibar

local _M = function()

    local icon = wibox.widget {
        widget  = wibox.widget.imagebox,
        id      = 'icon',
        image   = theme.keyboard_layout_icon,
        resize  = true,
    }

    local indicator = wibox.widget {
        widget  = awful.widget.keyboardlayout,
        id      = 'indicator',
    }

    local widget = wibox.widget {
        {
            {
                icon,
                indicator,
                layout = wibox.layout.fixed.horizontal,
            },
            widget = wibox.container.margin,
            left    = dpi(4),
            right   = dpi(4),
            top     = dpi(2),
            bottom  = dpi(2),
        },
        widget = container,
    }

    return widget
end

return _M
