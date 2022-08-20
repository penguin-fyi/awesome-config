-- Manage titlebars
local beautiful = require 'beautiful'
local gears     = require 'gears'

local rounded   = gears.shape.rounded_rect

local toggle    = require 'utils.manage_titlebar'

local function client_titlebars(args)

    args = args or {}
    args.radius = args.radius or beautiful.titlebar_radius or 0

    client.connect_signal('request::titlebars', function(c)
        require 'widgets.titlebar'(c, args)

        c.shape = function(cr, w, h)
            rounded(cr, w, h, args.radius)
        end
    end)

    client.connect_signal('request::manage', function(c)
        toggle(c)
    end)

    client.connect_signal('property::floating', function(c)
        toggle(c)
    end)

    client.connect_signal('request::tag', function(c)
        toggle(c)
    end)

    tag.connect_signal('property::layout', function(t)
        for _, c in pairs(t:clients()) do
            toggle(c)
        end
    end)
end

return client_titlebars

