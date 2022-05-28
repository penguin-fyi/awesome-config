-- Provide icon if client doesn't
local theme = require('beautiful')
local surface = require('gears.surface')
local lookup_icon = require('utils.icon_finder').lookup

theme.default_icon = lookup_icon(theme.default_icon)

client.connect_signal('request::manage', function(c)
    local icon = surface(theme.default_icon)
    if not next(c.icon_sizes) then
        c.icon = icon and icon._native or nil
    end
end)
