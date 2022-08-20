local beautiful = require 'beautiful'
local naughty   = require 'naughty'

local function notification_display(args)

    args = args or {}
    args.timeout = args.timeout or 10
    args.title   = args.title   or 'System Information'
    if args.ontop == nil then args.ontop = true end

    -- Setup notification defaults
    naughty.config.defaults.timeout = args.timeout
    naughty.config.defaults.title   = args.title
    naughty.config.defaults.ontop   = args.ontop

    -- Themed notification elements
    naughty.config.defaults.icon_size    = beautiful.notification_icon_size
    naughty.config.defaults.border_width = beautiful.notification_border_width
    naughty.config.defaults.max_width    = beautiful.notification_width
    naughty.config.defaults.position     = beautiful.notification_position
    naughty.config.defaults.opacity      = beautiful.notification_opacity
    naughty.config.padding               = beautiful.notification_padding

    -- Display of notification requested
    naughty.connect_signal('request::display', function(n)
        require 'widgets.notification'(n)
    end)
end

return notification_display
