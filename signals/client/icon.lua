-- Provide icon if client doesn't
local theme         = require 'beautiful'
local gsurf         = require 'gears.surface'
local lookup_icon   = require 'utils.icon_finder'.lookup

local function client_icon(args)
    args = args or {}
    local icon = args.icon or theme.default_icon

    icon = lookup_icon(icon)
    local surface = gsurf(icon)

    client.connect_signal('request::manage', function(c)
        if not next(c.icon_sizes) then
            c.icon = surface and surface._native or nil
        end
    end)
end

return client_icon

