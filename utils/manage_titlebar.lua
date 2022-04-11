-- Automatically show\hide titlebar depending on client\layout state
-- https://github.com/Anfid/cosy/blob/master/util.lua
local awful = require('awful')

local function manage_titlebar(c)
    local show = c.floating or awful.layout.get(c.screen) == awful.layout.suit.floating
    local geometry = c:geometry()

    if c.fullscreen then
        return
    end

    if show and not c.requests_no_titlebar then
        if c.titlebar == nil then
            c:emit_signal('request::titlebars', 'rules', {})
        end
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end

    if not awesome.startup then
        c:geometry(geometry)
    end
end

return manage_titlebar
