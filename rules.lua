local awful = require('awful')
local theme = require('beautiful')
local ruled = require('ruled')

local cfg_vars = _G.cfg.vars or nil

local vars = {}
vars.client_opacity_exclude_class = cfg_vars.client_opacity_exclude_class or {}
vars.client_opacity_exclude_instance = cfg_vars.client_opacity_exclude_instance or {}

ruled.client.connect_signal('request::rules', function()
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

    ruled.client.append_rule {
        id       = 'floating',
        rule_any = {
            instance = { 'copyq', 'pinentry' },
            class    = {
                'Arandr', 'Blueman-manager', 'Gpick', 'Kruler', 'Sxiv',
                'Tor Browser', 'Wpa_gui', 'veromix', 'xtightvncviewer'
            },
            name    = {
                'Event Tester',
            },
            role    = {
                'AlarmWindow',
                'ConfigManager',
                'pop-up',
            }
        },
        properties = { floating = true }
    }

    ruled.client.append_rule {
        id         = 'titlebars',
        rule_any   = { type = { 'normal' } },
        properties = { titlebars_enabled = true }
    }

    ruled.client.append_rule {
        id       = 'dynamic_opacity',
        rule_any = {
            class = vars.client_opacity_exclude_class,
            instance = vars.client_opacity_exclude_instance,
        },
        properties = { exclude_opacity = true }
    }
end)


ruled.notification.connect_signal('request::rules', function()
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            opacity = 0.5,
        }
    }

    ruled.notification.append_rule {
        rule       = { urgency = 'critical' },
        properties = {
            fg                  = theme.fg_error,
            bg                  = theme.bg_error,
            border_color        = theme.bg_error,
            implicit_timeout    = 30,
        }
    }

    ruled.notification.append_rule {
        rule       = { urgency = 'normal' },
        properties = {
            implicit_timeout    = 20
        }
    }

    ruled.notification.append_rule {
        rule       = { urgency = 'low' },
        properties = {
            implicit_timeout    = 10
        }
    }
end)
