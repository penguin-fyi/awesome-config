local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')
local naughty = require('naughty')
local container = require('widgets.buttons').gtk

local _M = function(n)

    local actions_template = wibox.widget {
        notification    = n,
        base_layout     = wibox.widget {
            layout      = wibox.layout.flex.horizontal,
            spacing     = dpi(2),
        },
        widget_template = {
            {
                {
                    {
                        widget = wibox.widget.textbox,
                        id     = 'text_role',
                    },
                    widget = wibox.container.place,
                },
                widget = container,
            },
            widget  = wibox.container.margin,
            margins = dpi(4),
        },
        widget  = naughty.list.actions,
        style   = {
            underline_normal    = false,
            underline_selected  = false,
        },
    }

    naughty.layout.box {
        notification    = n,
        type            = 'notification',
        screen          = awful.screen.preferred(),
        widget_template = {
            {
                {
                    {
                        {
                            {
                                {
                                    {
                                        {
                                            widget          = naughty.widget.icon,
                                            resize_strategy = 'center',
                                        },
                                        widget  = wibox.container.margin,
                                        margins = dpi(2),
                                    },
                                    layout      = wibox.layout.fixed.vertical,
                                    fill_space  = false,
                                },
                                {
                                    {
                                        {
                                            widget      = wibox.widget.textbox(),
                                            text        = n.title,
                                            font        = theme.font_bold,
                                            align       = 'left',
                                            ellipsize   = 'end',
                                            wrap        = 'none',
                                        },
                                        {
                                            widget      = wibox.widget.textbox(),
                                            text        = n.message,
                                            valign      = 'top',
                                            align       = 'left',
                                            ellipsize   = 'end',
                                            wrap        = 'word_char',
                                        },
                                        layout = wibox.layout.fixed.vertical,
                                        fill_space = false,
                                    },
                                    widget = wibox.container.margin,
                                    margins = dpi(2),
                                },
                                layout = wibox.layout.fixed.horizontal,
                            },
                            layout = wibox.layout.fixed.vertical,
                            spacing = dpi(2),
                            fill_space = false,
                        },
                        {
                            widget = actions_template,
                        },
                        layout = wibox.layout.fixed.vertical,
                        spacing = dpi(2),
                    },
                    widget = naughty.container.background,
                    id = 'background_role',
                    bg = theme.osd_bg,
                },
                widget = wibox.container.constraint,
                width = theme.notification_width,
                strategy = 'min',
            },
            widget = wibox.container.constraint,
            width = theme.notification_width,
            strategy = 'max',
        }
    }

end

return _M
