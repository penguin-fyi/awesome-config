-- Wallpaper
local theme = require 'beautiful'

local function screen_wallpaper(args)
    args = args or {}

    screen.connect_signal('request::wallpaper', function(s)
        if theme.wallpaper then
            require('widgets.wallpaper').simple(s, args)
        else
            require('widgets.wallpaper').color_with_icon(s, args)
        end
    end)

end

return screen_wallpaper
