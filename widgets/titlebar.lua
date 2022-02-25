local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')

local _M = function(c)

    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    awful.titlebar(c, {
            size = theme.titlebar_height or dpi(24),
        }).widget = {
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

return _M
