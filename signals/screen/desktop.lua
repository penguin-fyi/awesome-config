-- Add desktop icons
local function screen_desktop(args)
    args = args or {}

    screen.connect_signal('request::desktop_decoration', function(s)
        require('widgets.desktop')(s, args)
    end)
end

return screen_desktop
