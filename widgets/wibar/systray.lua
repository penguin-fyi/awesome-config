local awful     = require 'awful'
local theme     = require 'beautiful'
local dpi       = theme.xresources.apply_dpi
local gears     = require 'gears'
local wibox     = require 'wibox'

local container = require 'widgets.buttons'.wibar

local function systray(args)
    args = args or {}
    local visible_icon = args.systray_visible_icon or theme.systray_visible_icon
    local hidden_icon = args.systray_hidden_icon or theme.systray_hidden_icon

    local widget = wibox.widget {
        {
            {
                {
                    {
                        id = 'icon',
                        widget = wibox.widget.imagebox,
                        image = visible_icon,
                        resize = true,
                    },
                    widget = wibox.container.place,
                },
                id = 'button',
                widget = container,
            },
            {
                wibox.widget.systray,
                id = 'tray',
                widget = wibox.container.margin,
                left = dpi(2),
            },
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(2),
        },
        widget = wibox.container.place,
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
            icon:set_image(visible_icon)
        else
            icon:set_image(hidden_icon)
        end
    end)

    return awful.widget.only_on_screen(widget, 'primary')
end

return systray
