-- Manage titlebar of floating clients

local theme = require('beautiful')
local rounded_rect = require('gears.shape').rounded_rect
local manage_titlebar = require('utils.manage_titlebar')

local defaults = {}
defaults.height = 20
defaults.radius = 0
defaults.tooltips = false
defaults.fallback_name = ''

local function client_titlebars(args)
    args = args or {}
    local height = args.height or theme.titlebar_height or defaults.height
    local radius = args.radius or theme.border_radius or defaults.radius
    local tooltips = args.tooltips or defaults.tooltips
    local fallback_name = args.fallback_name or defaults.fallback_name

    client.connect_signal('request::titlebars', function(c)
        require('widgets.titlebar')(c, {
            height = height,
            enable_tooltip = tooltips,
            fallback_name = fallback_name,
        })

        c.shape = function(cr, w, h)
            rounded_rect(cr, w, h, radius)
        end
    end)

    client.connect_signal('request::manage', function(c)
        manage_titlebar(c)
    end)

    client.connect_signal('property::floating', function(c)
        manage_titlebar(c)
    end)

    client.connect_signal('request::tag', function(c)
        manage_titlebar(c)
    end)

    tag.connect_signal('property::layout', function(t)
        for _, c in pairs(t:clients()) do
            manage_titlebar(c)
        end
    end)
end

return client_titlebars

