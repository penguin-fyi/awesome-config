local awful = require 'awful'
require 'awful.autofocus'

local defaults = {}
defaults.sloppy = false
defaults.raise = true

local function client_focus(args)
    args = args or {}
    local sloppy = args.sloppy or defaults.sloppy
    local raise = args.raise or defaults.raise

    -- Enable sloppy focus
    if sloppy then
        client.connect_signal('mouse::enter', function(c)
            c:activate { context = 'mouse_enter', raise = raise }
        end)
    end

    -- Focus previous client
    client.connect_signal('request::unmanage', function()
        awful.client.focus.byidx(-1)
    end)

end

return client_focus
