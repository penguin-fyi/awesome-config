-- Awesome
local awful = require('awful')
local theme = require('beautiful')
local wibox = require('wibox')

-- Custom
local menu_button = require('widgets.buttons').menu
local menu_util = require('utils.menus')

-- Global
local cfg_vars = _G.cfg.vars or nil

-- Local
local vars = {}
vars.launcher_corner = cfg_vars.topbar_launcher_corner or 'tl'

local _M = function()

    local buttons = {
        awful.button({ }, 1, nil, function()
            _G.menus.main:toggle({
                coords = menu_util.set_corner(vars.launcher_corner)
            })
        end),
    }

    local launcher = awful.widget.button {
        image = theme.menu_button_icon,
        resize = true,
        buttons = buttons,
    }

    local launcher_widget = wibox.widget {
        {
            widget = launcher,
            forced_width = theme.menu_button_width,
            valign = 'center',
            halign = 'center',
        },
        widget = menu_button,
    }

    return launcher_widget
end

return _M
