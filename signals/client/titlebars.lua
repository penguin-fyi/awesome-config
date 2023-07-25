-- Manage titlebars
local function client_titlebars(args)
    args = args or {}

    client.connect_signal('request::titlebars', function(c)
        require 'widgets.titlebar'(c, args)
    end)
end

return client_titlebars

