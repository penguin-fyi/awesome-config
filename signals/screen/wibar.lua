-- Add wibar
local function screen_wibar(args)

    args = args or {}

    screen.connect_signal('request::desktop_decoration', function(s)
        require 'widgets.wibar'(s, args)
    end)
end

return screen_wibar
