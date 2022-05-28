-- awesome-freedesktop menu
-- https://github.com/lcpz/awesome-freedesktop/blob/master/menu.lua
local gio        = require("lgi").Gio
local awful_menu = require("awful.menu")
local menu_gen   = require("menubar.menu_gen")

local fd_menu = {}

-- Check if a path is a directory.
function fd_menu.is_dir(path)
    return gio.File.new_for_path(path):query_file_type({}) == "DIRECTORY"
end

-- Remove non existent paths in order to avoid issues
local existent_paths = {}
for _, v in pairs(menu_gen.all_menu_dirs) do
    if fd_menu.is_dir(v) then
        table.insert(existent_paths, v)
    end
end
menu_gen.all_menu_dirs = existent_paths

-- Determines whether an table includes a certain element
function fd_menu.has_value(tab, val)
    for _, v in pairs(tab) do
        if val:find(v) then
            return true
        end
    end
    return false
end

-- Use MenuBar parsing utils to build a menu for Awesome
function fd_menu.build(args)
    args = args or {}

    local before     = args.before or {}
    local after      = args.after or {}
    local skip_items = args.skip_items or {}
    local sub_menu   = args.sub_menu or false

    local result     = {}
    local menu      = awful_menu({ items = before })

    menu_gen.generate(function(entries)
        -- Add category icons
        for k, v in pairs(menu_gen.all_categories) do
            table.insert(result, { k, {}, v.icon })
        end

        -- Get items table
        for _, v in pairs(entries) do
            for _, cat in pairs(result) do
                if cat[1] == v.category then
                    if not fd_menu.has_value(skip_items, v.name) then
                        table.insert(cat[2], { v.name, v.cmdline, v.icon })
                    end
                    break
                end
            end
        end

        -- Cleanup things a bit
        for i = #result, 1, -1 do
            local v = result[i]
            if #v[2] == 0 then
                -- Remove unused categories
                table.remove(result, i)
            else
                --Sort entries alphabetically (by name)
                table.sort(v[2], function (a, b) return string.byte(a[1]) < string.byte(b[1]) end)
                -- Replace category name with nice name
                v[1] = menu_gen.all_categories[v[1]].name
            end
        end

        -- Sort categories alphabetically also
        table.sort(result, function(a, b) return string.byte(a[1]) < string.byte(b[1]) end)

        -- Add menu item to hold the generated menu
        if sub_menu then
            result = {{sub_menu, result}}
        end

        -- Add items to menu
        for _, v in pairs(result) do menu:add(v) end
        for _, v in pairs(after)  do menu:add(v) end
    end)

    return menu
end

return fd_menu
