-- Provide icon if client doesn't
local beautiful = require 'beautiful'
local gears     = require 'gears'

local surface   = gears.surface

local lookup_icon   = require 'utils.icon_finder'.lookup

local function client_icon(args)

    args = args or {}
    args.icon = args.icon or beautiful.default_icon

    local icon = lookup_icon(args.icon)
    icon = surface(icon)

    client.connect_signal('request::manage', function(c)
        if not next(c.icon_sizes) then
            c.icon = icon and icon._native or nil
        end
    end)
end

return client_icon
