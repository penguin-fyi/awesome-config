-- Awesome
local awful = require('awful')
local theme = require('beautiful')
local wibox = require('wibox')

local paths = require('config.paths')

local function wallpaper(s)
    if paths.wallpaper then
        -- Set image as background
        return awful.wallpaper {
            screen = s,
            widget = {
                {
                    image  = paths.wallpaper,
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
            fg = theme.wallpaper_fg,
            bg = theme.wallpaper_bg,
            widget = {
                {
                    {
                        markup = theme.wallpaper_markup,
                        font = theme.wallpaper_font,
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

return wallpaper
