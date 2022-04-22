local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')
local naughty = require('naughty')

local container = require('widgets.buttons').gtk

local function notif_widget(n)

    local icon = wibox.widget {
        notification    = n,
        resize_strategy = 'center',
        widget          = naughty.widget.icon,
    }

    local title = wibox.widget {
        notification    = n,
        text            = n.title,
        font            = theme.font_bold,
        forced_height   = theme.titlebar_height,
        ellipsize       = 'end',
        widget          = naughty.widget.title,
    }

    local message = wibox.widget {
        notification    = n,
        text            = n.text,
        valign          = 'top',
        align           = 'left',
        ellipsize       = 'end',
        widget          = naughty.widget.message,
    }

    local actions_template = {
        {
            {
                id          = 'icon_role',
                widget      = wibox.widget.imagebox,
            },
            {
                id          = 'text_role',
                ellipsize   = 'end',
                widget      = wibox.widget.textbox,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        widget = container,
    }

    local actions = wibox.widget {
        notification    = n,
        base_layout     = wibox.widget {
            layout      = wibox.layout.fixed.vertical,
            spacing     = dpi(4),
        },
        widget_template = actions_template,
        style   = {
            underline_normal    = false,
            underline_selected  = true,
        },
        widget  = naughty.list.actions,
    }

    local popup_template = {
        {
            {
                {
                    icon,
                    widget  = wibox.container.margin,
                    margins = dpi(8),
                },
                layout      = wibox.layout.fixed.vertical,
                fill_space  = false,
            },
            widget = wibox.container.background,
            bg = theme.notification_header_color,
        },
        {
            {
                {
                    {
                        title,
                        {
                            message,
                            widget = wibox.container.constraint,
                            height = theme.notification_width / 2,
                            strategy = 'max',
                        },
                        layout = wibox.layout.fixed.vertical,
                        spacing = 8,
                        spacing_widget = wibox.widget {
                            color       = theme.notification_header_color,
                            span_ratio  = 0.9,
                            widget      = wibox.widget.separator,
                        },
                    },
                    {
                        widget = actions,
                    },
                    layout = wibox.layout.fixed.vertical,
                    spacing = dpi(6),
                },
                widget = wibox.container.margin,
                margins = dpi(8),
            },
            widget = naughty.container.background,
        },
        layout = wibox.layout.fixed.horizontal,
        fill_space = true,
    }

    naughty.layout.box {
        notification    = n,
        type            = 'notification',
        minimum_width   = theme.notification_width / 2,
        maximum_width   = theme.notification_width,
        maximum_height  = theme.notification_width,
        placement       = function(w) awful.placement.top_right(w, {
                              honor_workarea = true,
                              margins = theme.useless_gap*2})
                          end,
        widget_template = popup_template,
    }

end

return notif_widget
