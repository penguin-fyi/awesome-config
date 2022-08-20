local awful = require 'awful'
require 'awful.autofocus'

local function client_focus(args)

    args = args or {}
    if args.sloppy == nil then args.sloppy = false end
    if args.raise == nil then args.raise = true end

    -- Enable sloppy focus
    if args.sloppy then
        client.connect_signal('mouse::enter', function(c)
            c:activate { context = 'mouse_enter', raise = args.raise }
        end)
    end

    -- Focus previous client
    client.connect_signal('request::unmanage', function()
        awful.client.focus.byidx(-1)
    end)

end

return client_focus
