-- Awesome
local awful = require('awful')

local _M = {}

-- Automatically show\hide titlebar depending on client\layout state
function _M.manage_titlebar(c)
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

-- Return true is client or layout is floating
function _M.check_float(c)
    return (c.floating or awful.layout.get(c.screen) == awful.layout.suit.floating)
        and not (c.fullscreen or c.maximized or c.maximized_vertical or c.maximized_horizontal)
end

return _M
