-- Add tags
local awful = require 'awful'

local function screen_tags(args)

    args = args or {}
    args.tags_auto = args.tags_auto or 9
    args.tags_list = args.tags_list or nil

    screen.connect_signal('request::desktop_decoration', function(s)
        -- Create numbered tags if no tag list provided
        if not args.tags_list then
            args.tags_list = {}
            for n = 1,args.tags_auto,1 do
                table.insert(args.tags_list, n)
            end
        end

        awful.tag(args.tags_list, s, awful.layout.layouts[1])
    end)
end

return screen_tags
