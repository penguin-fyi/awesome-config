-- Initial client position
local awful = require('awful')
local theme = require('beautiful')

client.connect_signal('request::manage', function(c)
    if not c.size_hints.user_position and
       not c.size_hints.program_position
    then
        awful.placement.no_overlap(c, {
            honor_workarea = true,
            margins = theme.useless_gap,
        })
        awful.placement.no_offscreen(c)
    end
end)
