local awful     = require 'awful'
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local container = require 'widgets.buttons'.menu
local menu_position = require 'utils.common'.menus.get_position

local function session(args)

    args = args or {}
    args.session_icon     = args.session_icon     or beautiful.session_button_icon
    args.session_width    = args.session_width    or dpi(24)
    args.session_position = args.session_position or 'tr'

    local mouse_buttons = {
        awful.button({ }, 1, nil, function()
            _G.menus.session:toggle({coords=menu_position(args.session_position)})
        end)
    }

    local widget = wibox.widget {
        widget = wibox.container.place,
        {
            widget  = container,
            buttons = mouse_buttons,
            {
                widget = awful.widget.button {
                    image  = args.session_icon,
                    resize = true,
                },
                forced_width = args.session_width,
                valign = 'center',
                halign = 'center',
            }
        }
    }

    return widget
end

return session
