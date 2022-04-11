local awful = require('awful')
local theme = require('beautiful')
local wibox = require('wibox')

local container = require('widgets.buttons').menu
local menu_position = require('utils.common').menus.get_position

local topbar_session = function()

    local buttons = {
        awful.button({ }, 1, nil, function()
            _G.menus.session:toggle({coords=menu_position('tr')})
        end),
    }

    local session_widget = wibox.widget {
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

    return session_widget
end

return topbar_session
