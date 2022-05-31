local awful = require 'awful'
local theme = require 'beautiful'
local dpi = theme.xresources.apply_dpi
local wibox = require 'wibox'

local defaults = {
    height = 20,
    enable_tooltip = false,
    fallback_name = '',
}

local function titlebar(c, args)
    args = args or {}
    local height = args.height or defaults.height
    local enable_tooltip = args.enable_tooltip or defaults.enable_tooltip
    local fallback_name = args.fallback_name or defaults.fallback_name

    awful.titlebar.enable_tooltip = enable_tooltip
    awful.titlebar.fallback_name = fallback_name

    local top = awful.titlebar(c, {size = dpi(height), position = 'top'})
    local left = awful.titlebar(c, {size = dpi(2), position = 'left'})
    local right = awful.titlebar(c, {size = dpi(2), position = 'right'})
    local bottom = awful.titlebar(c, {size = dpi(2), position = 'bottom'})

    local mouse_buttons = {
        awful.button({ }, 1, function()
            c:activate {context='titlebar', action='mouse_move'}
        end),
        awful.button({ }, 3, function()
            c:activate {context='titlebar', action='mouse_resize'}
        end),
    }

    top:setup {
        {
            id = 'titlebar_top',
            widget = wibox.container.background,
            forced_height = dpi(2),
        },
        {
            {
                {
                    awful.titlebar.widget.stickybutton(c),
                    awful.titlebar.widget.ontopbutton(c),
                    layout  = wibox.layout.fixed.horizontal,
                    spacing = dpi(2),
                },
                widget = wibox.container.margin,
                margins = dpi(1),
            },
            {
                {
                    {
                        awful.titlebar.widget.iconwidget(c),
                        awful.titlebar.widget.titlewidget(c),
                        layout  = wibox.layout.fixed.horizontal,
                        spacing = dpi(4),
                    },
                    widget = wibox.container.place,
                    buttons = mouse_buttons,
                },
                widget = wibox.container.margin,
                margins = dpi(1),
            },
            {
                {
                    awful.titlebar.widget.minimizebutton(c),
                    awful.titlebar.widget.maximizedbutton(c),
                    awful.titlebar.widget.closebutton(c),
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
            id = 'titlebar_left',
            widget = wibox.container.background,
            buttons = mouse_buttons,
        },
        layout = wibox.layout.flex.horizontal,
    }

    right:setup {
        {
            id = 'titlebar_right',
            widget = wibox.container.background,
            buttons = mouse_buttons,
        },
        layout = wibox.layout.flex.horizontal,
    }

    bottom:setup {
        {
            id = 'titlebar_bottom',
            widget = wibox.container.background,
            buttons = mouse_buttons,
        },
        layout = wibox.layout.flex.vertical,
    }
end

return titlebar
