-- Awesome
local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')

-- Wibar widget
local _M = function(s)
    s = s or screen.focused()

    return awful.wibar {
        screen       = s,
        position     = 'top',
        height       = dpi(24),
        border_width = theme.border_width,
        border_color = theme.wibar_bg,
        opacity      = theme.opacity,
        widget   = {
            {
                {
                    -- Left side
                    require('widgets.top_bar.launcher')(),
                    require('widgets.top_bar.taglist')(s),
                    require('widgets.top_bar.layout')(s),
                    require('widgets.top_bar.prompt')(s),
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(4),
                },
                {
                    -- Middle
                    {
                        require('widgets.top_bar.tasklist')(s),
                        layout = wibox.layout.align.horizontal,
                        fill_space = false,
                    },
                    widget = wibox.container.margin,
                    left = dpi(1),
                    right = dpi(4),
                },
                {
                    -- Right side
                    --require('widgets.top_bar.keyboard')(),
                    require('widgets.top_bar.systray')(),
                    require('widgets.top_bar.clock')(),
                    require('widgets.top_bar.session')(),
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(4),
                },
                layout = wibox.layout.align.horizontal,
                spacing = dpi(0),
            },
            widget = wibox.container.margin,
            margins = dpi(2),
        }
    }
end

return _M
