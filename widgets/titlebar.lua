-- Awesome
local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')

local vars = require('config.vars')

awful.titlebar.enable_tooltip = vars.titlebar_enable_tooltip
awful.titlebar.fallback_name = vars.titlebar_fallback_name

local function titlebar_widget(c)

    local widget = awful.titlebar(c, {
        size = theme.titlebar_height or dpi(24),
        position = 'top',
    })

    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = 'titlebar', action = 'mouse_move'  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = 'titlebar', action = 'mouse_resize'}
        end),
    }

    widget:setup {
        {
            {
                awful.titlebar.widget.stickybutton   (c),
                awful.titlebar.widget.ontopbutton    (c),
                layout  = wibox.layout.fixed.horizontal,
                spacing = dpi(2),
            },
            {
                nil,
                {
                    {
                        awful.titlebar.widget.iconwidget(c),
                        widget = wibox.container.margin,
                        margins = dpi(1),
                    },
                    awful.titlebar.widget.titlewidget(c),
                    layout  = wibox.layout.fixed.horizontal,
                    spacing = dpi(4),
                },
                nil,
                layout  = wibox.layout.align.horizontal,
                expand = 'outside',
                buttons = buttons,
            },
            {
                awful.titlebar.widget.minimizebutton (c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton    (c),
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(2),
            },
            layout = wibox.layout.align.horizontal
        },
        widget = wibox.container.margin,
        margins = dpi(2),
    }
end

return titlebar_widget
