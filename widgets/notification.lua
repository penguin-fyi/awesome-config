local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')
local naughty = require('naughty')

local container = require('widgets.buttons').gtk

local function notif_widget(n)

    local actions_template = wibox.widget {
        notification    = n,
        base_layout     = wibox.widget {
            layout      = wibox.layout.flex.vertical,
            --spacing     = dpi(2),
        },
        widget_template = {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            resize = true,
                            widget = wibox.widget.imagebox
                        },
                        widget  = wibox.container.margin,
                        margins = dpi(4),
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                widget = container,
            },
            widget  = wibox.container.margin,
            margins = dpi(4),
        },
        widget  = naughty.list.actions,
        style   = {
            icon_size_normal    = dpi(16),
            icon_size_selected  = dpi(16),
            underline_normal    = false,
            underline_selected  = true,
        },
    }

    naughty.layout.box {
        notification    = n,
        type            = 'notification',
        widget_template = {
            {
                {
                    {
                        {
                            {
                                widget          = naughty.widget.icon,
                                resize_strategy = 'center',
                            },
                            widget  = wibox.container.margin,
                            margins = dpi(8),
                        },
                        layout      = wibox.layout.fixed.vertical,
                        fill_space  = false,
                    },
                    widget = wibox.container.background,
                    bg = theme.wibar_bg
                },
                {
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
                            {
                                widget = actions_template,
                            },
                            layout = wibox.layout.fixed.vertical,
                        },
                        widget = wibox.container.margin,
                        margins = dpi(8),

                    },
                    id = 'background_role',
                    widget = naughty.container.background,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            widget = wibox.container.constraint,
            width = theme.notification_width,
            strategy = 'max',
        }
    }

end

return notif_widget
