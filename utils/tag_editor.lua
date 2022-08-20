-- https://github.com/lcpz/lain/blob/master/util/init.lua
local awful = require 'awful'

local tag_editor = {}

function tag_editor.add(layout)
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

function tag_editor.rename()
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

function tag_editor.move(dir)
    local tag = awful.screen.focused().selected_tag
    if dir == 'left' then
        tag.index = tag.index-1
    elseif dir == 'right' then
        tag.index = tag.index+1
    end
end

function tag_editor.delete()
    local tag = awful.screen.focused().selected_tag
    if not tag then return end
    tag:delete()
end

return tag_editor
