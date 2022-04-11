local awful = require('awful')
local theme = require('beautiful')
local wibox = require('wibox')

local container = require('widgets.buttons').menu
local menu_position = require('utils.common').menus.get_position

local topbar_launcher = function()

    local buttons = {
        awful.button({ }, 1, nil, function()
            _G.menus.main:toggle({coords=menu_position('tl')})
        end),
    }

    local launcher_button = awful.widget.button {
        image = theme.menu_button_icon,
        resize = true,
        buttons = buttons,
    }

    local launcher_widget = wibox.widget {
        {
            widget = launcher_button,
            forced_width = theme.menu_button_width,
            valign = 'center',
            halign = 'center',
        },
        widget = container,
    }

    return launcher_widget
end

return topbar_launcher
