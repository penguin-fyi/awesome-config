local awful     = require 'awful'
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local function about_popup(args)

    args = args or {}
    args.icon_fg   = args.icon_fg   or beautiful.bg_focus
    args.icon_bg   = args.icon_bg   or beautiful.wibar_bg
    args.icon_size = args.icon_size or dpi(48)

    awful.spawn.easy_async('awesome -v', function(stdout, _, _, _)
        local ver_info = stdout:gsub('\n[^\n]*$', '')
        awful.popup {
            screen                  = awful.screen.focused(),
            type                    = 'splash',
            visible                 = true,
            ontop                   = true,
            hide_on_right_click     = true,
            placement               = awful.placement.centered,
            shape                   = beautiful.button_shape,
            widget = {
                {
                    {
                        {
                            image         = beautiful.theme_assets.awesome_icon(
                                                args.icon_size, args.icon_fg, args.icon_bg
                                            ),
                            forced_height = dpi(args.icon_size),
                            forced_width  = dpi(args.icon_size),
                            clip_shape    = beautiful.button_shape,
                            resize        = true,
                            widget        = wibox.widget.imagebox
                        },
                        widget = wibox.container.margin,
                        margins = dpi(8),
                    },
                    widget = wibox.container.background,
                    bg = args.icon_bg,
                },
                {
                    {
                        markup = ver_info,
                        widget = wibox.widget.textbox,
                    },
                    widget = wibox.container.margin,
                    margins = dpi(8),
                },
                layout = wibox.layout.fixed.horizontal,
            },
        }
    end)

end

return about_popup
