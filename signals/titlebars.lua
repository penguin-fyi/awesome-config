-- Manage titlebar of floating clients
local manage_titlebar = require('utils.manage_titlebar')
local theme = require('beautiful')

client.connect_signal('request::titlebars', function(c)
    require('widgets.titlebar')(c)

    c.shape = theme.titlebar_shape
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
