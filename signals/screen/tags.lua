-- Add tags
local awful = require 'awful'

local defaults = {}
defaults.tags_list = nil
defaults.tags_auto = 9

local function screen_tags(args)
    args = args or {}
    local tags_auto = args.tags_auto or defaults.tags_auto
    local tags_list = args.tags_list or defaults.tags_list

    screen.connect_signal('request::desktop_decoration', function(s)
        if not tags_list then
            -- Create numbered tags if no tag list provided
            tags_list = {}
            for n = 1,tags_auto,1 do
                table.insert(tags_list, n)
            end
        end
        awful.tag(tags_list, s, awful.layout.layouts[1])
    end)
end

return screen_tags
