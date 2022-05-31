-- Tasklist
local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')

local container = require('widgets.buttons').tasklist

local defaults = {}
defaults.task_width = 200
defaults.menu_width = 160

local function tasklist(s, args)
    args = args or {}
    local task_width = args.task_width or theme.tasklist_button_width or defaults.task_width
    local menu_width = args.menu_width or theme.tasklist_menu_width or defaults.menu_width

    local mouse_buttons = {
        awful.button({ }, 1, function (c)
            c:activate { context = 'tasklist', action = 'toggle_minimization' }
        end),
        awful.button({ }, 3, function() awful.menu.client_list { theme = { width = menu_width } } end),
        awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
        awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
    }

    local layout = {
        layout = wibox.layout.flex.horizontal,
        spacing = dpi(4),
    }

    local template = {
        {
            {
                wibox.widget.base.make_widget(),
                widget = wibox.container.background,
                forced_height = dpi(2),
            },
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            resize = true,
                            widget = wibox.widget.imagebox,
                        },
                        widget = wibox.container.margin,
                        margins = dpi(2),
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(4),
                },
                widget = wibox.container.margin,
                left = dpi(4),
                right = dpi(6),
            },
            {
                wibox.widget.base.make_widget(),
                id = 'background_role',
                widget = wibox.container.background,
                forced_height = dpi(2),
            },
            layout = wibox.layout.align.vertical,
        },
        widget = container,
        forced_width = dpi(task_width),
    }

    local widget = wibox.widget {
        awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            layout  = layout,
            buttons = mouse_buttons,
            widget_template = template,
        },
        widget = wibox.container.place,
    }

    return widget
end

return tasklist
