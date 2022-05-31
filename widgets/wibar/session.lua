local awful = require 'awful'
local theme = require 'beautiful'
local wibox = require 'wibox'

local container = require 'widgets.buttons'.menu
local menu_position = require 'utils.common'.menus.get_position

local defaults = {}
defaults.width = 24
defaults.position = 'tr'

local function session(args)
    args = args or {}
    local icon = args.session_icon or theme.session_button_icon
    local width = args.session_width or defaults.width
    local position = args.session_position or defaults.position

    local mouse_buttons = {
        awful.button({ }, 1, nil, function()
            _G.menus.session:toggle({coords=menu_position(position)})
        end)
    }

    local widget = wibox.widget {
        {
            {
                widget = awful.widget.button {
                    image = icon,
                    resize = true,
                },
                forced_width = width,
                valign = 'center',
                halign = 'center',
            },
            widget = container,
            buttons = mouse_buttons,
        },
        widget = wibox.container.place,
    }

    return widget
end

return session
