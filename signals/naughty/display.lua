local theme = require('beautiful')
local naughty = require('naughty')

local defaults = {}
defaults.timeout = 10
defaults.title = 'System Information'
defaults.ontop = true

local function notification_display(args)
    args = args or {}
    local timeout = args.timeout or defaults.timeout
    local title = args.titile or defaults.title
    local ontop = args.ontop or defaults.ontop

    -- Setup notification defaults
    naughty.config.defaults.timeout = timeout
    naughty.config.defaults.title = title
    naughty.config.defaults.ontop = ontop

    -- Themed notification elements
    naughty.config.defaults.icon_size = theme.notification_icon_size
    naughty.config.defaults.border_width = theme.notification_border_width
    naughty.config.defaults.max_width = theme.notification_width
    naughty.config.defaults.position = theme.notification_position
    naughty.config.defaults.opacity = theme.notification_opacity
    naughty.config.padding = theme.notification_padding

    -- Display of notification requested
    naughty.connect_signal('request::display', function(n)
        require('widgets.notification')(n)
    end)
end

return notification_display
