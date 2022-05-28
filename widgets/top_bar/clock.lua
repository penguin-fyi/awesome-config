local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local join = require('gears.table').join
local wibox = require('wibox')

local container = require('widgets.buttons').wibar

local default_vars = {
    topbar_calendar_enabled = false,
    topbar_calendar_hover = false,
}
local user_vars = require('config.vars')
local vars = join(default_vars, user_vars)

local topbar_clock = function()

    local textclock = wibox.widget.textclock(' %a %b %d, %H:%M ', 30)

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

    if vars.topbar_calendar_enabled then
        local calendar = require('awful.widget.calendar_popup').month()

        function calendar.call_calendar(self, offset, position, _)
            local focus_screen = awful.screen.focused()
            awful.widget.calendar_popup.call_calendar(self, offset, position, focus_screen)
        end

        calendar:attach(widget, 'tr', { on_hover=vars.topbar_calendar_hover })
        calendar.opacity = theme.opacity
    end

    return widget
end

return topbar_clock
