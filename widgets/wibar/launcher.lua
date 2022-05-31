local awful = require('awful')
local theme = require('beautiful')
local wibox = require('wibox')

local container = require('widgets.buttons').menu
local menu_position = require('utils.common').menus.get_position

local defaults = {}
defaults.icon = theme.awesome_icon
defaults.width = 32
defaults.position = 'tl'

local function launcher(args)
    args = args or {}
    local launcher_icon = args.launcher_icon or theme.menu_button_icon or defaults.icon
    local width = args.launcher_width or theme.menu_button_width or defaults.width
    local position = args.launcher_position or defaults.position

    local mouse_buttons = {
        awful.button({ }, 1, nil, function()
            _G.menus.main:toggle({coords=menu_position(position)})
        end),
    }

    local button = awful.widget.button {
        image = launcher_icon,
        resize = true,
        buttons = mouse_buttons,
    }

    local widget = wibox.widget {
        {
            {
                widget = button,
                forced_width = width,
                valign = 'center',
                halign = 'center',
            },
            widget = container,
        },
        widget = wibox.container.place,
    }

    return widget
end

return launcher
