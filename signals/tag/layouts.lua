-- Set default layouts
local awful = require 'awful'

local defaults = {}
defaults.layout_list = {
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
    local layout_list = args.layout_list or defaults.layout_list

    tag.connect_signal('request::default_layouts', function()
        awful.layout.append_default_layouts(layout_list)
    end)
end

return tag_layouts
