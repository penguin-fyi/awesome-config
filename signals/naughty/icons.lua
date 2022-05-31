local theme = require('beautiful')
local naughty = require('naughty')
local lookup_icon = require('utils.icon_finder').lookup

local defaults = {}
defaults.icon_formats = {'svg', 'png'}
defaults.icon_dirs = {
    '/usr/share/icons/gnome/',
    '/usr/share/pixmaps/',
}

local function notification_icons(args)
    args = args or {}
    local icon_formats = args.icon_formats or defaults.icon_formats
    local icon_dirs = args.icon_dirs or defaults.icon_dirs

    -- Notification icons
    naughty.config.icon_formats = icon_formats
    naughty.config.icon_dirs = icon_dirs

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

end

return notification_icons
