-- Keyboard layout indicator
local awful     = require 'awful'
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local container = require 'widgets.buttons'.wibar

local function keyboard(args)

    args = args or {}
    args.keyboard_icon    = args.keyboard_icon    or beautiful.keyboard_layout_icon
    args.keyboard_tooltip = args.keyboard_tooltip or 'Keyboard layout'

    local widget = wibox.widget {
        widget = wibox.container.place,
        {
            widget = container,
            {
                widget  = wibox.container.margin,
                margins = dpi(2),
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

    local tooltip  = awful.tooltip {
        text       = args.keyboard_tooltip,
        align      = 'bottom',
        delay_show = 1,
    }

    tooltip:add_to_object(widget)

    return widget
end

return keyboard
