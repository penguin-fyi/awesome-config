-- Awesome
local awful = require('awful')
local theme = require('beautiful')
local wibox = require('wibox')

-- Local
local vars = {}
vars.text = theme.wallpaper_markup or awesome.hostname
vars.font = theme.wallpaper_font or 'Monospace 64'
vars.fg = theme.wallpaper_fg or '#000'
vars.bg = theme.wallpaper_bg or '#333'
vars.image = _G.cfg.paths.wallpaper or nil

local _M = function(s)
    if vars.image then
        -- Set image as background
        return awful.wallpaper {
            screen = s,
            widget = {
                {
                    image  = vars.image,
                    horizontal_fit_policy = 'fit',
                    vertical_fit_policy   = 'fit',
                    resize = true,
                    widget = wibox.widget.imagebox,
                },
                valign = 'center',
                halign = 'center',
                tiled  = false,
                widget = wibox.container.tile,
            }
        }
    else
        -- Set color and text as background
        return awful.wallpaper {
            screen = s,
            fg = vars.fg,
            bg = vars.bg,
            widget = {
                {
                    {
                        markup = vars.text,
                        font = vars.font,
                        align = 'center',
                        valign = 'center',
                        widget = wibox.widget.textbox,
                    },
                    point  = awful.placement.centered,
                    layout = wibox.layout.flex.vertical,
                },
                widget = wibox.layout.manual,
            }
        }
    end
end

return _M
