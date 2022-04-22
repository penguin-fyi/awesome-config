-- Awesome
local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')

local vars = require('config.vars')

awful.titlebar.enable_tooltip = vars.titlebar_enable_tooltip
awful.titlebar.fallback_name = vars.titlebar_fallback_name

local function titlebar(c)

    local buttons = {
        awful.button({ }, 1, function()
            c:activate {context='titlebar', action='mouse_move'}
        end),
        awful.button({ }, 3, function()
            c:activate {context='titlebar', action='mouse_resize'}
        end),
    }

    local top = awful.titlebar(c, {
        size = theme.titlebar_height or dpi(28),
        position = 'top',
    })

    top:setup {
        {
            widget = wibox.container.background,
            forced_height = 2,
        },
        {
            {
                {
                    awful.titlebar.widget.stickybutton   (c),
                    awful.titlebar.widget.ontopbutton    (c),
                    layout  = wibox.layout.fixed.horizontal,
                    spacing = dpi(2),
                },
                widget = wibox.container.margin,
                margins = dpi(1),
            },
            {
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
                widget = wibox.container.margin,
                margins = dpi(1),
            },
            {
                {
                    awful.titlebar.widget.minimizebutton (c),
                    awful.titlebar.widget.maximizedbutton(c),
                    awful.titlebar.widget.closebutton    (c),
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(2),
                },
                widget = wibox.container.margin,
                margins = dpi(1),
            },
            layout = wibox.layout.align.horizontal,
        },
        layout = wibox.layout.fixed.vertical,
    }

    local left = awful.titlebar(c, {size = 2, position = 'left'})
    left:setup {
        {
            widget = wibox.container.background,
            buttons = buttons,
        },
        layout = wibox.layout.flex.horizontal,
    }

    local right = awful.titlebar(c, {size = 2, position = 'right'})
    right:setup {
        {
            widget = wibox.container.background,
            buttons = buttons,
        },
        layout = wibox.layout.flex.horizontal,
    }

    local bottom = awful.titlebar(c, {size = 2, position = 'bottom'})
    bottom:setup {
        {
            widget = wibox.container.background,
            buttons = buttons,
        },
        layout = wibox.layout.flex.vertical,
    }
end

return titlebar
