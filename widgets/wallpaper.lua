-- Awesome
local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

-- Custom
local vars = {}
vars.text = beautiful.wallpaper_markup or ' penguin, fyi '
vars.font = beautiful.wallpaper_font or 'Monospace 64'
vars.fg = beautiful.wallpaper_fg or '#000'
vars.bg = beautiful.wallpaper_bg or '#333'

local _M = function(s)

    return awful.wallpaper {
        screen = s,
        widget = {
            {
                {
                    widget = wibox.widget.textbox,
                    markup = vars.text,
                    font = vars.font,
                    align = 'center',
                    valign = 'center',
                },
                point  = awful.placement.centered,
                layout = wibox.layout.flex.vertical,
            },
            widget = wibox.layout.manual,
        }
    }

end

return _M
