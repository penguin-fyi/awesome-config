local awful = require('awful')
local ruled = require('ruled')

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
