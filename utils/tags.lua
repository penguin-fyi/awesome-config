local awful = require('awful')
local mod = _G.cfg.modkey

local _tag = {}

function _tag.add(layout)
    local tags = awful.screen.focused().tags
    awful.prompt.run {
        prompt       = 'Add: ',
        text         = tostring(#tags+1),
        textbox      = awful.screen.focused().prompt.widget,
        exe_callback = function(name)
            if not name or #name == 0 then return end
            awful.tag.add(name, {
                screen = awful.screen.focused(),
                layout = layout or awful.layout.suit.floating
            }):view_only()
        end
    }
end

function _tag.rename()
    local tag = awful.screen.focused().selected_tag
    awful.prompt.run {
        prompt       = 'Edit: ',
        text         = tag.name,
        textbox      = awful.screen.focused().prompt.widget,
        exe_callback = function(new_name)
            if not new_name or #new_name == 0 then return end
            if tag then
                tag.name = new_name
            end
        end
    }
end

function _tag.move(dir)
    local tag = awful.screen.focused().selected_tag
    if dir == 'left' then
        tag.index = tag.index-1
    elseif dir == 'right' then
        tag.index = tag.index+1
    end
end

function _tag.delete()
    local tag = awful.screen.focused().selected_tag
    if not tag then return end
    tag:delete()
end

return _M
