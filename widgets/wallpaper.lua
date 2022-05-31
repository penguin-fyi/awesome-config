local awful = require('awful')
local theme = require('beautiful')
local is_file = require('gears.filesystem').file_readable
local wibox = require('wibox')

local wallpaper = {}

function wallpaper.simple(s, args)
    args = args or {}

    local bg = args.bg or theme.wallpaper_bg or '#000000'
    local image = args.image or theme.wallpaper or nil

    local widget = awful.wallpaper { screen = s, bg = bg }

    if type(image) == 'string' and is_file(image) then
        local imagebox = {
            {
                image   = image,
                resize  = true,
                widget  = wibox.widget.imagebox,
            },
            valign  = 'center',
            halign  = 'center',
            tiled   = false,
            widget  = wibox.container.tile,
        }

        widget:set_widget(imagebox)
    end

    return widget
end

function wallpaper.color_with_text(s, args)
    args = args or {}

    local fg = args.fg or theme.wallpaper_fg or '#666666'
    local bg = args.bg or theme.wallpaper_bg or '#000000'
    local markup = args.markup or theme.wallpaper_markup or nil
    local font = args.font or theme.wallpaper_font or 'Sans 64'
    local place = args.placement or theme.wallpaper_placement or 'centered'
    local margin = args.margin or theme.wallpaper_margin or 20

    local widget = awful.wallpaper { screen = s, fg = fg, bg = bg }

    if type(markup) == 'string' then
        local textbox = {
            {
                {
                    {
                        markup  = markup,
                        font    = font,
                        align   = 'center',
                        valign  = 'center',
                        widget  = wibox.widget.textbox,
                    },
                    point  = awful.placement[place],
                    layout = wibox.layout.flex.vertical,
                },
                widget = wibox.layout.manual,
            },
            widget = wibox.container.margin,
            margins = margin,
        }

        widget:set_widget(textbox)
    end

    return widget
end

function wallpaper.color_with_icon(s, args)
    args = args or {}

    local fg = args.fg or theme.wallpaper_fg or theme.fg_focus
    local bg = args.bg or theme.wallpaper_bg or theme.bg_focus
    local icon = args.icon or theme.wallpaper_icon or nil
    local size = args.size or theme.wallpaper_icon_size or 96
    local margin = args.margin or theme.wallpaper_margin or 20
    local place = args.placement or theme.wallpaper_placement or 'centered'

    if not icon then
        icon = theme.theme_assets.awesome_icon(size, fg, bg)
    end

    local widget = awful.wallpaper { screen = s, fg = fg, bg = bg }

    if icon then
        local imagebox = {
            {
                {
                    image           = icon,
                    resize          = true,
                    forced_width    = size,
                    forced_height   = size,
                    clip_shape      = theme.button_shape,
                    point           = awful.placement[place],
                    widget          = wibox.widget.imagebox,
                },
                widget = wibox.layout.manual,
            },
            widget  = wibox.container.margin,
            margins = margin,
        }

        widget:set_widget(imagebox)
    end

    return widget
end

return wallpaper
