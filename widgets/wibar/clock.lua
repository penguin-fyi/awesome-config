-- Clock and calendar
local awful     = require 'awful'
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local container = require 'widgets.buttons'.wibar

local function clock(args)

    args = args or {}
    args.clock_format   = args.clock_format      or ' %a %b %d, %H:%M '
    args.clock_interval = args.clock_interval    or 30
    args.cal_pos  = args.calendar_position or 'tr'
    if args.cal_enable == nil then args.cal_enable = true end
    if args.cal_hover == nil then args.cal_hover = false end

    local textclock = wibox.widget.textclock(args.clock_format, args.clock_interval)

    local tooltip = awful.tooltip {
        text = 'Toggle calendar',
        align = 'bottom',
        delay_show = 1,
    }

    local widget = wibox.widget {
        {
            {
                textclock,
                widget  = wibox.container.margin,
                margins = dpi(2),
            },
            widget = container,
        },
        widget = wibox.container.place,
    }

    tooltip:add_to_object(widget)

    if args.cal_enable then
        local calendar = require 'awful.widget.calendar_popup'.month()

        function calendar.call_calendar(self, offset, position, _)
            local focus_screen = awful.screen.focused()
            awful.widget.calendar_popup.call_calendar(self, offset, position, focus_screen)
        end

        calendar:attach(widget, args.cal_pos, {on_hover=args.cal_hover})
        calendar.opacity = beautiful.opacity
    end

    return widget
end

return clock
