local awful = require('awful')
local theme = require('beautiful')
local ruled = require('ruled')

ruled.notification.connect_signal('request::rules', function()
    -- Match all
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen              = awful.screen.preferred,
            opacity             = theme.notification_opacity,
        }
    }
    -- Critical
    ruled.notification.append_rule {
        rule       = { urgency = 'critical' },
        properties = {
            fg                  = theme.fg_error,
            bg                  = theme.bg_error,
            border_color        = theme.bg_error,
            implicit_timeout    = 30,
        }
    }
    -- Normal
    ruled.notification.append_rule {
        rule       = { urgency = 'normal' },
        properties = {
            implicit_timeout    = 20
        }
    }
    -- Low
    ruled.notification.append_rule {
        rule       = { urgency = 'low' },
        properties = {
            implicit_timeout    = 10
        }
    }
end)

