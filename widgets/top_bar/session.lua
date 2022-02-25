local awful = require('awful')
local theme = require('beautiful')
local wibox = require('wibox')
local container = require('widgets.buttons').menu
local menu_util = require('utils.menus')

local _M = function()

    local buttons = {
        awful.button({ }, 1, nil, function()
            local pos = menu_util.set_corner('tr')
            _G.menus.session:toggle({coords=pos})
        end),
    }

    local menu_widget = wibox.widget {
        {
            widget = awful.widget.button {
                image = theme.session_button_icon,
                resize = true,
            },
            forced_width = theme.menu_height,
            valign = 'center',
            halign = 'center',
        },
        widget = container,
        buttons = buttons,
    }

    return menu_widget
end

return _M
