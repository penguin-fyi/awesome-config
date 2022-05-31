-- Client placement

local awful = require('awful')

local defaults = {}
defaults.margins = 4

local function client_placement(args)
    args = args or {}
    local margins = args.margins or defaults.margins

    client.connect_signal('request::manage', function(c)
        -- Default client placement
        if not c.size_hints.user_position and
           not c.size_hints.program_position
        then
            awful.placement.no_overlap(c, {
                honor_workarea = true,
                margins = margins,
            })
            awful.placement.no_offscreen(c)
        end

        -- Child client placement
        if c.transient_for then
            awful.placement.centered(c, {
                parent = c.transient_for
            })
            awful.placement.no_offscreen(c)
        end

    end)

    client.connect_signal('request::tag', function(c)
        -- Move child to same tag as parent
        if c.transient_for then
            c:move_to_tag(c.transient_for.first_tag)
        end
    end)
end

return client_placement
