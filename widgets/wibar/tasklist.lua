-- Tasklist
local awful     = require 'awful'
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local button = require 'widgets.buttons'.tasklist
local menu = require 'widgets.menus.tasklist'

local function tasklist(s, args)

    args = args or {}
    args.task_width = args.task_width or beautiful.tasklist_button_width or dpi(200)
    args.menu_width = args.menu_width or beautiful.tasklist_menu_width   or dpi(160)
    if args.tasklist_tooltip == nil then args.tasklist_tooltip = false end

    local mouse_buttons = {
        awful.button({ }, 1, function(c)
            c:activate { context = 'tasklist', action = 'toggle_minimization' }
        end),
        awful.button({ }, 2, function(c)
            c:kill()
        end),
        awful.button({ }, 3, function(c)
            menu(c):show()
        end),
        awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
        awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
    }

    local layout = {
        layout = wibox.layout.flex.horizontal,
        spacing = dpi(4),
    }

    local template = {
        widget = button,
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

    if args.tasklist_tooltip then
        local tooltip = awful.tooltip {
            delay_show = 1,
            align = 'bottom',
        }

        function template:create_callback(c, _, _)
            tooltip:add_to_object(self)
            self:connect_signal("mouse::enter", function()
                tooltip.text = c.name or "Unknown"
            end)
        end
    end

    return wibox.widget {
        widget = wibox.container.place,
        awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            layout  = layout,
            buttons = mouse_buttons,
            widget_template = template,
        }
    }
end

return tasklist
