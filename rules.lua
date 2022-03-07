-- Awesome
local awful = require('awful')
local theme = require('beautiful')
local ruled = require('ruled')

-- Client rules
ruled.client.connect_signal('request::rules', function()
    -- Match all
    ruled.client.append_rule {
        id         = 'global',
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
            callback  = awful.client.setslave,
        }
    }
    -- Titlebars
    ruled.client.append_rule {
        id         = 'titlebars',
        rule_any   = { type = { 'normal' } },
        properties = { titlebars_enabled = true }
    }
end)

-- Notification rules
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
