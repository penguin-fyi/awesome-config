local awful = require('awful')
local ruled = require('ruled')

ruled.client.connect_signal('request::rules', function()
    -- PCManFM
    ruled.client.append_rule {
        rule       = { class = 'Pcmanfm' },
        properties = {
            width = 610,
            height = 360,
            placement = awful.placement.next_to_mouse,
        }
    }
end)
