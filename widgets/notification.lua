-- Awesome
local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')
local naughty = require('naughty')

-- Custom
local cfg_paths = _G.cfg.paths or nil
local container = require('widgets.buttons').gtk

-- Local
local paths = {}
paths.icon_search_dirs = cfg_paths.icon_search_dirs or {
    '/usr/share/icons/gnome/',
    '/usr/share/pixmaps/',
}

naughty.config.defaults.ontop           = true
naughty.config.defaults.icon_size       = theme.notification_icon_size
naughty.config.defaults.timeout         = 10
naughty.config.defaults.title           = 'System Information'
naughty.config.defaults.border_width    = theme.border_width
naughty.config.defaults.max_width       = theme.notification_width
naughty.config.defaults.position        = theme.notification_position
naughty.config.defaults.opacity         = theme.notification_opacity
naughty.config.padding                  = theme.notification_padding
naughty.config.icon_dirs                = paths.icon_search_dirs
naughty.config.icon_formats             = { 'svg', 'png' }

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
