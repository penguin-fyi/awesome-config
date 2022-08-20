local awful     = require 'awful'
local beautiful = require 'beautiful'

local function manage_titlebar(c, args)

    args = args or {}
    args.width  = args.width  or beautiful.titlebar_width
    args.height = args.height or beautiful.titlebar_height

    local show = c.floating or awful.layout.get(c.screen) == awful.layout.suit.floating
    local geometry = c:geometry()

    if c.fullscreen then
        return
    end

    if show and not c.requests_no_titlebar then
        if c.titlebar == nil then
            c:emit_signal('request::titlebars', 'rules', {})
        end
        awful.titlebar(c, { size = args.height, position = 'top' })
    else
        awful.titlebar(c, { size = args.width, position = 'top' })
    end

    if not awesome.startup then
        c:geometry(geometry)
    end
end

return manage_titlebar
