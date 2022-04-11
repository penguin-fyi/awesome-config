local awful = require('awful')
local theme = require('beautiful')
local wibox = require('wibox')

local function about_popup()

    local icon_fg       = theme.bg_focus
    local icon_bg       = theme.wibar_bg
    local icon_size     = 48

    awful.spawn.easy_async('awesome -v', function(stdout, _, _, _)
        local ver_info = stdout:gsub('\n[^\n]*$', '')
        awful.popup {
            type                    = 'splash',
            visible                 = true,
            ontop                   = true,
            hide_on_right_click     = true,
            placement               = awful.placement.centered,
            shape                   = theme.button_shape,
            widget = {
                {
                    {
                        {
                            image         = theme.theme_assets.awesome_icon(
                                                icon_size, icon_fg, icon_bg
                                            ),
                            forced_height = icon_size,
                            forced_width  = icon_size,
                            clip_shape    = theme.button_shape,
                            resize        = true,
                            widget        = wibox.widget.imagebox
                        },
                        widget = wibox.container.margin,
                        margins = 8,
                    },
                    widget = wibox.container.background,
                    bg = icon_bg,
                },
                {
                    {
                        markup = ver_info,
                        widget = wibox.widget.textbox,
                    },
                    widget = wibox.container.margin,
                    margins = 8,
                },
                layout = wibox.layout.fixed.horizontal,
            },
        }
    end)

end

return about_popup
