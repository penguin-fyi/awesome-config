local awful = require('awful')
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')
local container = require('widgets.buttons').wibar

local cfg_vars = _G.cfg.vars

local vars = {}
vars.calendar_enabled = cfg_vars.topbar_calendar_enabled or false
vars.calendar_hover = cfg_vars.topbar_calendar_hover or false

local _M = function(kwargs)
    local args = cfg_vars or kwargs or {}
    local show_calendar = args.show_calendar or true
    local hover_calendar = args.hover_calendar or false

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
            layout = wibox.layout.align.vertical,
        },
        widget = container,
    }

    if vars.calendar_enabled then
        local calendar = require('awful.widget.calendar_popup').month()
        function calendar.call_calendar(self, offset, position, _)
            local focus_screen = awful.screen.focused()
            awful.widget.calendar_popup.call_calendar(self, offset, position, focus_screen)
        end

        calendar:attach(widget, 'tr', { on_hover=vars.calendar_hover })
        calendar.opacity = theme.opacity
    end

    return widget
end

return _M
