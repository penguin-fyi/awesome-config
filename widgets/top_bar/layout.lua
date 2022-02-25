-- Awesome
local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')

-- Custom
local container = require('widgets.buttons').wibar

local _M = function(s)
    s = s or screen.focused()

    local buttons = {
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc(-1) end),
        awful.button({ }, 5, function () awful.layout.inc( 1) end),
    }

    local w = wibox.widget {
        {
            awful.widget.layoutbox {
                screen  = s,
                buttons = buttons,
            },
            widget = wibox.container.margin,
            margins = dpi(3),
        },
        widget = container,
    }

    return w
end

return _M
