local awful     = require 'awful'
local beautiful = require 'beautiful'
--local gears     = require 'gears'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local container = require 'widgets.buttons'.wibar

local function systray(args)

    args = args or {}
    args.systray_visible_icon = args.systray_visible_icon or beautiful.systray_visible_icon
    args.systray_visible_text = args.systray_visible_text or 'Hide tray'
    args.systray_hidden_icon  = args.systray_hidden_icon  or beautiful.systray_hidden_icon
    args.systray_hidden_text  = args.systray_hidden_text  or 'Show tray'

    local mouse_buttons = {
        awful.button({ }, 1, nil, function()
            awesome.emit_signal('systray_toggle')
        end)
    }

    local tooltip = awful.tooltip {
        text = 'Toggle systray',
        align = 'bottom',
        delay_show = 1,
    }

    local widget = wibox.widget {
        widget = wibox.container.place,
        {
            layout  = wibox.layout.fixed.horizontal,
            spacing = dpi(2),
            {
                widget  = container,
                id      = 'button',
                buttons = mouse_buttons,
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

    local toggle_btn = widget:get_children_by_id('button')[1]
    local toggle_icon = widget:get_children_by_id('icon')[1]
    local tray_wdg = widget:get_children_by_id('tray')[1]

    tooltip:add_to_object(toggle_btn)

    awesome.connect_signal('systray_toggle', function()
        tray_wdg.visible = not tray_wdg.visible
        if tray_wdg.visible then
            toggle_icon:set_image(args.systray_visible_icon)
            tooltip.text = 'Hide systray'
        else
            toggle_icon:set_image(args.systray_hidden_icon)
            tooltip.text = 'Show systray'
        end
    end)

    return awful.widget.only_on_screen(widget, 'primary')
end

return systray
