-- Add session dialogs
local function screen_session(args)
    args = args or {}

    screen.connect_signal('request::desktop_decoration', function(s)
        require('widgets.session')(s, args)
    end)
end

return screen_session
