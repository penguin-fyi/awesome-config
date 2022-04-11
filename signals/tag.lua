local awful = require('awful')

local manage_titlebar = require('utils.manage_titlebar')

local vars = require('config.vars')

--- Tags
-- Default layouts requested for tag
tag.connect_signal('request::default_layouts', function()
    awful.layout.append_default_layouts(vars.tag_default_layouts)
end)

-- Layout property for tag has changed
tag.connect_signal('property::layout', function(t)
    for _, c in pairs(t:clients()) do
        manage_titlebar(c)
    end
end)
