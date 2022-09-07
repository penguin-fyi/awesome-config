-- Main menu button
local awful     = require 'awful'
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local container = require 'widgets.buttons'.menu
local menu_position = require 'utils.common'.menus.get_position

local function launcher(args)

    args = args or {}
    args.launcher_icon     = args.launcher_icon     or beautiful.menu_button_icon or beautiful.awesome_icon
    args.launcher_width    = args.launcher_width    or beautiful.menu_button_width or dpi(32)
    args.launcher_position = args.launcher_position or 'tl'
    args.launcher_tooltip  = args.launcher_tooltip  or 'Applications'

    local mouse_buttons = {
        awful.button({ }, 1, nil, function()
            _G.menus.main:toggle({coords=menu_position(args.launcher_position)})
        end),
    }

    local button = awful.widget.button {
        image = args.launcher_icon,
        resize = true,
        buttons = mouse_buttons,
    }

    if args.launcher_tooltip then
        local tooltip = awful.tooltip {
            text = args.launcher_tooltip,
            align = 'bottom_right',
            delay_show = 1,
        }
        tooltip:add_to_object(button)
    end

    local widget = wibox.widget {
        widget = wibox.container.place,
        {
            widget = container,
            {
                widget = button,
                forced_width = args.launcher_width,
                valign = 'center',
                halign = 'center',
            }
        }
    }

    return widget
end

return launcher
