local awful = require('awful')
require('awful.autofocus')
local theme = require('beautiful')
local surface = require('gears.surface')

local manage_titlebar = require('utils.manage_titlebar')

local vars = require('config.vars')

--- Clients
-- New client requests to be managed
client.connect_signal('request::manage', function(c)
    -- Initial client position
    if not c.size_hints.user_position and
       not c.size_hints.program_position
    then
        awful.placement.no_overlap(c, {
            honor_workarea = true,
            margins = theme.useless_gap,
        })
        awful.placement.no_offscreen(c)
    end

    -- Center dialogs over parent
    if c.transient_for then
        awful.placement.centered(c, {
            parent = c.transient_for
        })
        awful.placement.no_offscreen(c)
    end

    -- Provide icon if client doesn't
    if not next(c.icon_sizes) then
        local icon = surface(vars.client_default_icon)
        c.icon = icon and icon._native or nil
    end

    -- Manage titlebar of floating clients
    manage_titlebar(c)

    -- Set client shape
    c.shape = theme.titlebar_shape
end)

-- Floating property for client has changed
client.connect_signal('property::floating', function(c)
    manage_titlebar(c)
end)

client.connect_signal('request::tag', function(c)
    -- Open client on the same tag than parent tag
    if c.transient_for then
        c:move_to_tag(c.transient_for.first_tag)
    end
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
client.connect_signal('request::unmanage', function()
    -- Focus previous client
    awful.client.focus.byidx(-1)
end)

