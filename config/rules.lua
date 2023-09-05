local awful = require 'awful'
local theme = require 'beautiful'

local client_rules = {
  {
    id         = 'global',
    rule       = { },
    properties = {
      focus     = awful.client.focus.filter,
      raise     = true,
      screen    = awful.screen.preferred,
      --placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      callback  = awful.client.setslave,
    }
  },
  {
    id         = 'titlebars',
    rule_any   = { type = { 'normal', 'dialog' } },
    properties = { titlebars_enabled = true },
  }
}

local notification_rules = {
    {
        rule       = { },
        properties = {
            screen              = awful.screen.preferred,
            opacity             = theme.notification_opacity,
        }
    },
    {
        rule       = { urgency = 'critical' },
        properties = {
            fg                  = theme.fg_error,
            bg                  = theme.bg_error,
            border_color        = theme.bg_error,
            implicit_timeout    = 30,
        }
    },
    -- Normal
    {
        rule       = { urgency = 'normal' },
        properties = {
            implicit_timeout    = 20
        }
    },
    -- Low
    {
        rule       = { urgency = 'low' },
        properties = {
            implicit_timeout    = 10
        }
    },
}

return {
  client        = client_rules,
  notifications = notification_rules,
}
