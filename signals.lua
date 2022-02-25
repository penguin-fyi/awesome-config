-- Awesome
local awful = require('awful')
local theme = require('beautiful')
local surface = require('gears.surface')
local lookup_icon = require('menubar.utils').lookup_icon
local naughty = require('naughty')

-- Custom
local client_util = require('utils.clients')

local cfg_vars = _G.cfg.vars or nil
local cfg_paths = _G.cfg.paths or nil

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

vars.client_opacity_focus = cfg_vars.client_opacity_focus or 1
vars.client_opacity_unfocus = cfg_vars.client_opacity_unfocus or 1

vars.client_default_icon = lookup_icon('preferences-activities') or theme.awesome_icon

local paths = {}
paths.icon_search_dirs = cfg_paths.icon_search_dirs or {
    '/usr/share/icons/gnome/',
    '/usr/share/pixmaps/',
}

local floatgeoms = {}

-- Tag
-- Default layouts requested for tag
tag.connect_signal('request::default_layouts', function()
    awful.layout.append_default_layouts(vars.tag_default_layouts)
end)

-- Layout property for tag has changed
tag.connect_signal('property::layout', function(t)
    for _, c in pairs(t:clients()) do
        if client_util.check_float(c) then
            c:geometry(floatgeoms[c.window])
        end

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
        local opts = {
            honor_workarea = true,
            margins = theme.useless_gap or 4,
        }
        --awful.placement.centered(c, opts)
        --awful.placement.no_overlap(c, opts)
        awful.placement.no_offscreen(c, opts)
    end

    -- Center dialogs over parent
    if c.transient_for then
        awful.placement.centered(c, { parent = c.transient_for })
        awful.placement.no_offscreen(c)
    end

    -- Provide icon if client doesn't
    if not next(c.icon_sizes) then
        local icon = surface(vars.client_default_icon)
        c.icon = icon and icon._native or nil
    end

    -- Track geometry of floating clients
    if client_util.check_float(c) then
        floatgeoms[c.window] = c:geometry()
    end

    -- Manager titlebar
    client_util.manage_titlebar(c)

    -- Set client shape
    c.shape = theme.titlebar_shape
end)

-- Floating property for client has changed
client.connect_signal('property::floating', function(c)
    -- Track geometry of floating clients
    if client_util.check_float(c) then
        c:geometry(floatgeoms[c.window])
    end

    -- Manager titlebar
    client_util.manage_titlebar(c)
end)

-- Geometry of client has changed
client.connect_signal('property::geometry', function(c)
    -- Track geometry of floating clients
    if client_util.check_float(c) then
        floatgeoms[c.window] = c:geometry()
    end
end)

-- Titlebar for client is requested
client.connect_signal('request::titlebars', function(c)
    require('widgets.titlebar')(c)
end)

-- Client has received focus
client.connect_signal('focus', function(c)
    if not (c.exclude_opacity or c.fullscreen) then
        c.opacity = vars.client_opacity_focus
    end
end)

-- Client has lost focus
client.connect_signal('unfocus', function(c)
    if not (c.exclude_opacity or c.fullscreen) then
        c.opacity = vars.client_opacity_unfocus
    end
end)

-- Mouse has entered client area
client.connect_signal('mouse::enter', function(c)
    if vars.client_focus_sloppy then
        c:activate { context = 'mouse_enter', raise = vars.client_focus_raise }
    end
end)

-- Mouse has left client area
client.connect_signal('unmanage', function(c)
    floatgeoms[c.window] = nil
    awful.client.focus.byidx(-1)
end)

-- Notifications
naughty.config.defaults.ontop           = true
naughty.config.defaults.icon_size       = theme.notification_icon_size
naughty.config.defaults.timeout         = 10
naughty.config.defaults.title           = 'System Information'
naughty.config.defaults.border_width    = theme.border_width
naughty.config.defaults.max_width       = theme.notification_width
naughty.config.defaults.position        = theme.notification_position
naughty.config.defaults.opacity         = theme.notification_opacity
naughty.config.padding                  = theme.notification_padding
naughty.config.icon_dirs                = paths.icon_search_dirs
naughty.config.icon_formats             = { 'svg', 'png' }

-- Application icon requested
naughty.connect_signal('request::icon', function(n, context, hints)
    n.icon = theme.notification_default_icon
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
