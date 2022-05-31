-- Clock and calendar
local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')

local container = require('widgets.buttons').wibar

local defaults = {
    clock_format = ' %a %b %d, %H:%M ',
    clock_interval = 30,
    calendar_enabled = false,
    calendar_hover = false,
    calendar_position = 'tr',
}

local function clock(args)
    args = args or {}
    local format = args.clock_format or defaults.clock_format
    local interval = args.clock_interval or defaults.clock_interval
    local cal_enable = args.calendar_enabled or defaults.calendar_enabled
    local cal_hover = args.calendar_hover or defaults.calendar_hover
    local cal_pos = args.calendar_position or defaults.calendar_position

    local textclock = wibox.widget.textclock(format, interval)

    local widget = wibox.widget {
        {
            {
                textclock,
                widget = wibox.container.margin,
                left    = dpi(4),
                right   = dpi(4),
                top     = dpi(2),
                bottom  = dpi(2),
            },
            widget = container,
        },
        widget = wibox.container.place,
    }

    if cal_enable then
        local calendar = require('awful.widget.calendar_popup').month()

        function calendar.call_calendar(self, offset, position, _)
            local focus_screen = awful.screen.focused()
            awful.widget.calendar_popup.call_calendar(self, offset, position, focus_screen)
        end

        calendar:attach(widget, cal_pos, {on_hover=cal_hover})
        calendar.opacity = theme.opacity
    end

    return widget
end

return clock
