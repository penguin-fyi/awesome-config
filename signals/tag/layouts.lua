-- Set default layouts
local awful = require 'awful'

local default_layout_list = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
}

local function tag_layouts(args)

    args = args or {}
    args.layout_list = args.layout_list or default_layout_list

    tag.connect_signal('request::default_layouts', function()
        awful.layout.append_default_layouts(args.layout_list)
    end)
end

return tag_layouts
