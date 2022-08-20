-- Tasklist
local awful     = require 'awful'
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local container = require 'widgets.buttons'.tasklist

local function tasklist(s, args)

    args = args or {}
    args.task_width = args.task_width or beautiful.tasklist_button_width or dpi(200)
    args.menu_width = args.menu_width or beautiful.tasklist_menu_width   or dpi(160)

    local mouse_buttons = {
        awful.button({ }, 1, function (c)
            c:activate { context = 'tasklist', action = 'toggle_minimization' }
        end),
        awful.button({ }, 3, function() awful.menu.client_list { theme = { width = args.menu_width } } end),
        awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
        awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
    }

    local layout = {
        layout = wibox.layout.flex.horizontal,
        spacing = dpi(4),
    }

    local template = {
        widget = container,
        forced_width = dpi(args.task_width),
        {
            layout = wibox.layout.align.vertical,
            {
                widget = wibox.container.background,
                forced_height = dpi(2),
                wibox.widget.base.make_widget(),
            },
            {
                widget = wibox.container.margin,
                left   = dpi(4),
                right  = dpi(6),
                {
                    layout  = wibox.layout.fixed.horizontal,
                    spacing = dpi(4),
                    {
                        widget  = wibox.container.margin,
                        margins = dpi(2),
                        {
                            widget = wibox.widget.imagebox,
                            id     = 'icon_role',
                            resize = true,
                        }
                    },
                    {
                        widget = wibox.widget.textbox,
                        id     = 'text_role',
                    }
                }
            },
            {
                widget = wibox.container.background,
                id     = 'background_role',
                forced_height = dpi(2),
                wibox.widget.base.make_widget(),
            }
        }
    }

    local widget = wibox.widget {
        widget = wibox.container.place,
        awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            layout  = layout,
            buttons = mouse_buttons,
            widget_template = template,
        }
    }

    return widget
end

return tasklist
