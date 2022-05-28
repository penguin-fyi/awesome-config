local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local join = require('gears.table').join
local wibox = require('wibox')

local default_vars = {
    titlebar_enable_tooltip = false,
    titlebar_fallback_name = '',

}
local user_vars = require('config.vars')
local vars = join(default_vars, user_vars)

-- Common options
awful.titlebar.enable_tooltip = vars.titlebar_enable_tooltip
awful.titlebar.fallback_name = vars.titlebar_fallback_name

local function titlebar(c)

    -- Define widgets
    local top = awful.titlebar(c, {
        size = theme.titlebar_height or dpi(28),
        position = 'top',
    })
    local left = awful.titlebar(c, {size = dpi(2), position = 'left'})
    local right = awful.titlebar(c, {size = dpi(2), position = 'right'})
    local bottom = awful.titlebar(c, {size = dpi(2), position = 'bottom'})

    -- Mouse buttons
    local buttons = {
        awful.button({ }, 1, function()
            c:activate {context='titlebar', action='mouse_move'}
        end),
        awful.button({ }, 3, function()
            c:activate {context='titlebar', action='mouse_resize'}
        end),
    }

    -- Setup widgets
    top:setup {
        {
            widget = wibox.container.background,
            forced_height = dpi(2),
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

    left:setup {
        {
            widget = wibox.container.background,
            buttons = buttons,
        },
        layout = wibox.layout.flex.horizontal,
    }

    right:setup {
        {
            widget = wibox.container.background,
            buttons = buttons,
        },
        layout = wibox.layout.flex.horizontal,
    }

    bottom:setup {
        {
            widget = wibox.container.background,
            buttons = buttons,
        },
        layout = wibox.layout.flex.vertical,
    }
end

return titlebar
