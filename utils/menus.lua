local awful = require('awful')
local theme = require('beautiful')

local menu_util = {}

function menu_util.set_corner(corner)
    local width = 0
    local height = 0

    local index = awful.screen.focused().index

    local menu_width = theme.menu_width or 160
    local border_width = theme.menu_border_width or 0
    local total_width = menu_width+(border_width*2)

    for s = 1, screen.count() do
        width = width + screen[s].geometry.width
        height = screen[s].geometry.height
        if s == index then break end
    end

    if corner == 'tl' then
        return { x = 0, y = 0 }
    elseif corner == 'tr' then
        return { x = width-total_width, y = 0 }
    elseif corner == 'bl' then
        return { x = 0, y = height }
    elseif corner == 'br' then
        return { x = width-total_width, y = height }
    end
end

menu_util.hide_all = function()
    for _, menu in pairs(_G.menus) do
        menu:hide()
    end
end

return menu_util
