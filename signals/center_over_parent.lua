-- Center dialogs over parent
local awful = require('awful')

client.connect_signal('request::manage', function(c)
    if c.transient_for then
        awful.placement.centered(c, {
            parent = c.transient_for
        })
        awful.placement.no_offscreen(c)
    end

end)

client.connect_signal('request::tag', function(c)
    if c.transient_for then
        c:move_to_tag(c.transient_for.first_tag)
    end
end)
