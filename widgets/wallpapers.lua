local awful = require('awful')
local theme = require('beautiful')
local is_file = require('gears.filesystem').file_readable
local wibox = require('wibox')

local wallpaper = {}

function wallpaper.simple(s, args)
    args = args or {}

    local fg = args.fg or theme.wallpaper_fg or '#666666'
    local bg = args.bg or theme.wallpaper_bg or '#000000'
    local image = args.image or theme.wallpaper or nil

    if is_file(image) then
        return awful.wallpaper {
            screen = s,
            fg = fg,
            bg = bg,
            widget = {
                {
                    image = image,
                    resize = true,
                    widget = wibox.widget.imagebox,
                },
                valign = 'center',
                halign = 'center',
                tiled  = false,
                widget = wibox.container.tile,
            }
        }
    end
end

function wallpaper.color(s, args)
    args = args or {}

    local fg = args.fg or theme.wallpaper_fg or '#666666'
    local bg = args.bg or theme.wallpaper_bg or '#000000'
    local markup = args.markup or theme.wallpaper_markup or nil
    local font = args.font or theme.wallpaper_font or theme.font

    local text_widget = {}
    if markup then
        text_widget = {
            {
                {
                    markup = markup,
                    font = font,
                    align = 'center',
                    valign = 'center',
                    widget = wibox.widget.textbox,
                },
                point  = awful.placement.centered,
                layout = wibox.layout.flex.vertical,
            },
            widget = wibox.layout.manual,
        }
    end

    -- Set color and text as background
    return awful.wallpaper {
        screen = s,
        fg = fg,
        bg = bg,
        widget = text_widget,
    }
end

return wallpaper
