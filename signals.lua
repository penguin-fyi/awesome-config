-- Awesome
local awful = require('awful')
local theme = require('beautiful')
local surface = require('gears.surface')
local lookup_icon = require('menubar.utils').lookup_icon
local naughty = require('naughty')

-- Custom
local client_util = require('utils.clients')

-- Global
local cfg_vars = _G.cfg.vars or nil

-- Local
local vars = {}
vars.tag_default_layouts = cfg_vars.tag_default_layouts or {
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
vars.screen_tags_list = cfg_vars.screen_tags_list or nil
vars.screen_tags_auto = cfg_vars.screen_tags_auto or 9

vars.client_focus_sloppy = cfg_vars.client_focus_sloppy or false
vars.client_focus_raise = cfg_vars.client_focus_raise or false

vars.client_default_icon = lookup_icon('preferences-activities') or theme.awesome_icon

-- Tag
-- Default layouts requested for tag
tag.connect_signal('request::default_layouts', function()
    awful.layout.append_default_layouts(vars.tag_default_layouts)
end)

-- Layout property for tag has changed
tag.connect_signal('property::layout', function(t)
    for _, c in pairs(t:clients()) do
        client_util.manage_titlebar(c)
    end
end)

-- Screen
-- Decorations requested for screen
screen.connect_signal('request::desktop_decoration', function(s)
    if not vars.screen_tags_list then
        vars.screen_tags_list = {}
        for n = 1,vars.screen_tags_auto,1 do
            table.insert(vars.screen_tags_list, n)
        end
    end
    awful.tag(vars.screen_tags_list, s, awful.layout.layouts[1])

    require('widgets.top_bar')(s)
    require('widgets.session')(s)
end)

-- Wallpaper requested for screen
screen.connect_signal('request::wallpaper', function(s)
    require('widgets.wallpaper')(s)
end)

-- Clients
-- New client requests to be managed
client.connect_signal('request::manage', function(c)
    -- Initial client position
    if not c.size_hints.user_position and
       not c.size_hints.program_position
    then
        local place_opts = {
            honor_workarea = true,
            margins = theme.useless_gap,
        }
        awful.placement.no_overlap(c, place_opts)
        awful.placement.no_offscreen(c, place_opts)
    end

    -- Center dialogs over parent
    if c.transient_for then
        awful.placement.centered(c, {
            parent = c.transient_for
        })
    end

    -- Provide icon if client doesn't
    if not next(c.icon_sizes) then
        local icon = surface(vars.client_default_icon)
        c.icon = icon and icon._native or nil
    end

    -- Manage titlebar of floating clients
    client_util.manage_titlebar(c)

    -- Set client shape
    c.shape = theme.titlebar_shape
end)

-- Floating property for client has changed
client.connect_signal('property::floating', function(c)
    client_util.manage_titlebar(c)
end)

-- Titlebar for client is requested
client.connect_signal('request::titlebars', function(c)
    require('widgets.titlebar')(c)
end)

-- Mouse has entered client area
client.connect_signal('mouse::enter', function(c)
    -- Sloppy focus
    if vars.client_focus_sloppy then
        c:activate { context = 'mouse_enter', raise = vars.client_focus_raise }
    end
end)

-- Client will become unmanaged
client.connect_signal('unmanage', function()
    -- Focus previous client
    awful.client.focus.byidx(-1)
end)

-- Notifications
-- Application icon requested
naughty.connect_signal('request::icon', function(n, context, hints)
    n.icon = lookup_icon('help-info') or nil
    if context ~= 'app_icon' then return end

    local path = lookup_icon(hints.app_icon)
                 or lookup_icon(hints.app_icon:lower())
    if path then
        n.icon = path
    end
end)

-- Notification action icon requested
naughty.connect_signal('request::action_icon', function(a, context, hints)
    a.icon = theme.default_app_icon
    if context ~= 'action_icon' then return end

    local path = lookup_icon(hints.id)
                 or lookup_icon(hints.id:lower())
    if path then
        a.icon = path
    end
end)

-- Display of notification requested
naughty.connect_signal('request::display', function(n)
    require('widgets.notification')(n)
end)
