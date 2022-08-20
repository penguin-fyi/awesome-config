-- Keyboard layout indicator
local awful     = require 'awful'
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local container = require 'widgets.buttons'.wibar

local function keyboard(args)

    args = args or {}
    args.keybord_icon = args.keyboard_icon or beautiful.keyboard_layout_icon

    local widget = wibox.widget {
        widget = wibox.container.place,
        {
            widget = container,
            {
                widget = wibox.container.margin,
                left    = dpi(4),
                right   = dpi(4),
                top     = dpi(2),
                bottom  = dpi(2),
                {
                    layout = wibox.layout.fixed.horizontal,
                    {
                        widget  = wibox.widget.imagebox,
                        id      = 'icon',
                        image   = args.keyboard_icon,
                        resize  = true,
                    },
                    {
                        widget  = awful.widget.keyboardlayout,
                        id      = 'indicator',
                    }
                }
            }
        }
    }

    return widget
end

return keyboard
