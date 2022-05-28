local awful = require('awful')
local theme = require('beautiful')
local join = require('gears.table').join

local default_vars = {
    tag_default_layouts = {
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
    },
    screen_tags_list = nil,
    screen_tags_auto = 9,
}
local user_vars = require('config.vars')
local vars = join(default_vars, user_vars)

-- Set default layouts
tag.connect_signal('request::default_layouts', function()
    awful.layout.append_default_layouts(vars.tag_default_layouts)
end)

-- Decorate screen
screen.connect_signal('request::desktop_decoration', function(s)
    -- Add tags
    if not vars.screen_tags_list then
        -- Create numbered tags if no tag list provided
        vars.screen_tags_list = {}
        for n = 1,vars.screen_tags_auto,1 do
            table.insert(vars.screen_tags_list, n)
        end
    end
    awful.tag(vars.screen_tags_list, s, awful.layout.layouts[1])

    -- Add widgets
    require('widgets.top_bar')(s)
    require('widgets.session')(s)
end)

-- Wallpaper
screen.connect_signal('request::wallpaper', function(s)
    if theme.wallpaper then
        require('widgets.wallpapers').simple(s)
    else
        require('widgets.wallpapers').color(s)
    end
end)

-- Focus previous client
require('awful.autofocus')
client.connect_signal('request::unmanage', function()
    awful.client.focus.byidx(-1)
end)

-- Additional signals
require('signals.naughty')
require('signals.titlebars')
require('signals.initial_placement')
require('signals.center_over_parent')
require('signals.sloppy_focus')
require('signals.default_icon')
