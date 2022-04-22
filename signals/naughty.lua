local theme = require('beautiful')
local lookup_icon = require('menubar.utils').lookup_icon
local naughty = require('naughty')

local paths = require('config.paths')

-- Settings
naughty.config.defaults.ontop           = true
naughty.config.defaults.icon_size       = theme.notification_icon_size
naughty.config.defaults.timeout         = 10
naughty.config.defaults.title           = 'System Information'
naughty.config.defaults.border_width    = theme.notification_border_width
naughty.config.defaults.max_width       = theme.notification_width
naughty.config.defaults.position        = theme.notification_position
naughty.config.defaults.opacity         = theme.notification_opacity
naughty.config.padding                  = theme.notification_padding
naughty.config.icon_dirs                = paths.icon_search_dirs
naughty.config.icon_formats             = { 'svg', 'png' }

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

-- Action icon requested
naughty.connect_signal('request::action_icon', function(a, context, hints)
    a.icon = theme.awesome_icon or nil
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
