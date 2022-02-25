local awful = require('awful')

local _M = {}

function _M.manage_titlebar(c)
    if c.fullscreen then
        return
    end

    local show = c.floating or awful.layout.get(c.screen) == awful.layout.suit.floating

    if show then
        if c.titlebar == nil then
            c:emit_signal('request::titlebars', 'rules', {})
        end
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end

    awful.placement.no_offscreen(c)
end

function _M.check_float(c)
    return (c.floating or awful.layout.get(c.screen) == awful.layout.suit.floating)
        and not (c.fullscreen or c.maximized or c.maximized_vertical or c.maximized_horizontal)
end

return _M
