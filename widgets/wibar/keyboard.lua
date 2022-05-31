-- Keyboard layout indicator
local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')

local container = require('widgets.buttons').wibar

local function keyboard(args)
    args = args or {}
    local icon = args.keyboard_icon or theme.keyboard_layout_icon

    local widget = wibox.widget {
        {
            {
                {
                    {
                        widget  = wibox.widget.imagebox,
                        id      = 'icon',
                        image   = icon,
                        resize  = true,
                    },
                    {
                        widget  = awful.widget.keyboardlayout,
                        id      = 'indicator',
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                widget = wibox.container.margin,
                left    = dpi(4),
                right   = dpi(4),
                top     = dpi(2),
                bottom  = dpi(2),
            },
            widget = container,
        },
        widget = wibox.container.place,
    }

    return widget
end

return keyboard
