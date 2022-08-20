local awful     = require 'awful'
local beautiful = require 'beautiful'
local gears     = require 'gears'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local container = require 'widgets.buttons'.wibar

local function systray(args)

    args = args or {}
    args.systray_visible_icon = args.systray_visible_icon or beautiful.systray_visible_icon
    args.systray_hidden_icon  = args.systray_hidden_icon  or beautiful.systray_hidden_icon

    local widget = wibox.widget {
        widget = wibox.container.place,
        {
            layout  = wibox.layout.fixed.horizontal,
            spacing = dpi(2),
            {
                widget = container,
                id     = 'button',
                {
                    widget = wibox.container.place,
                    {
                        widget = wibox.widget.imagebox,
                        id     = 'icon',
                        image  = args.systray_visible_icon,
                        resize = true,
                    }
                }
            },
            {
                widget = wibox.container.margin,
                id     = 'tray',
                left   = dpi(2),
                wibox.widget.systray,
            }
        }
    }

    local button = widget:get_children_by_id('button')[1]

    button:buttons(gears.table.join(
        awful.button({}, 1, nil, function()
            awesome.emit_signal('systray_toggle')
        end)
    ))

    local icon = widget:get_children_by_id('icon')[1]
    local tray = widget:get_children_by_id('tray')[1]

    awesome.connect_signal('systray_toggle', function()
        tray.visible = not tray.visible
        if tray.visible then
            icon:set_image(args.systray_visible_icon)
        else
            icon:set_image(args.systray_hidden_icon)
        end
    end)

    return awful.widget.only_on_screen(widget, 'primary')
end

return systray
