local awful     = require 'awful'
local beautiful = require 'beautiful'
local naughty   = require 'naughty'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local container = require 'widgets.buttons'.gtk

local function notif_widget(n)

    local icon = wibox.widget {
        widget          = naughty.widget.icon,
        notification    = n,
        resize_strategy = 'center',
    }

    local title = wibox.widget {
        widget          = naughty.widget.title,
        notification    = n,
        text            = n.title,
        font            = beautiful.font_bold,
        forced_height   = beautiful.titlebar_height,
        ellipsize       = 'end',
    }

    local message = wibox.widget {
        widget          = naughty.widget.message,
        notification    = n,
        text            = n.text,
        valign          = 'top',
        align           = 'left',
        ellipsize       = 'end',
    }

    local actions_template = {
        widget = container,
        {
            layout = wibox.layout.fixed.horizontal,
            {
                widget      = wibox.widget.imagebox,
                id          = 'icon_role',
            },
            {
                widget      = wibox.widget.textbox,
                id          = 'text_role',
                ellipsize   = 'end',
            }
        }
    }

    local actions = wibox.widget {
        widget  = naughty.list.actions,
        notification    = n,
        base_layout     = wibox.widget {
            layout      = wibox.layout.fixed.vertical,
            spacing     = dpi(4),
        },
        style   = {
            underline_normal    = false,
            underline_selected  = true,
        },
        widget_template = actions_template,
    }

    local popup_template = {
        layout = wibox.layout.fixed.horizontal,
        fill_space = true,
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
            bg = beautiful.notification_header_color,
        },
        {
            widget = naughty.container.background,
            {
                widget  = wibox.container.margin,
                margins = dpi(8),
                {
                    layout  = wibox.layout.fixed.vertical,
                    spacing = dpi(6),
                    {
                        layout = wibox.layout.fixed.vertical,
                        spacing = dpi(8),
                        spacing_widget = wibox.widget {
                            color       = beautiful.notification_header_color,
                            span_ratio  = 0.9,
                            widget      = wibox.widget.separator,
                        },
                        title,
                        {
                            widget = wibox.container.constraint,
                            height = beautiful.notification_width/2,
                            strategy = 'max',
                            message,
                        },
                    },
                    {
                        widget = actions,
                    }
                }
            }
        }
    }

    naughty.layout.box {
        notification    = n,
        type            = 'notification',
        minimum_width   = beautiful.notification_width/2,
        maximum_width   = beautiful.notification_width,
        maximum_height  = beautiful.notification_width,
        placement       = function(w) awful.placement.top_right(w, {
                              honor_workarea = true,
                              margins = beautiful.useless_gap*2})
                          end,
        widget_template = popup_template,
    }

end

return notif_widget
