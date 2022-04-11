local awful = require('awful')

local vars = require('config.vars')

--- Screens
-- Decorations requested for screen
screen.connect_signal('request::desktop_decoration', function(s)
    if not vars.screen_tags_list then
        vars.screen_tags_list = {}
        for n = 1,vars.screen_tags_auto,1 do
            table.insert(vars.screen_tags_list, n)
        end
    end
    awful.tag(vars.screen_tags_list, s, awful.layout.layouts[1])

    require('widgets.top_bar')(s)
    require('widgets.session')(s)
end)

-- Wallpaper requested for screen
screen.connect_signal('request::wallpaper', function(s)
    require('widgets.wallpaper')(s)
end)
