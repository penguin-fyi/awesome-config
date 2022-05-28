local join = require('gears.table').join

local default_paths = {
    xsd_conf = os.getenv('HOME')..'/.xsettingsd.conf'
}
local user_paths = require('config.paths')
local paths = join(default_paths, user_paths)

local valid_keys = {
    'Net/DoubleClickTime',
    'Net/DoubleClickDistance',
    'Net/DndDragThreshold',
    'Net/CursorBlink',
    'Net/CursorBlinkTime',
    'Net/ThemeName',
    'Net/IconThemeName',
    'Xft/Antialias',
    'Xft/Hinting',
    'Xft/HintStyle',
    'Xft/RGBA',
    'Xft/DPI',
    'Gtk/CanChangeAccels',
    'Gtk/ColorPalette',
    'Gtk/FontName',
    'Gtk/IconSizes',
    'Gtk/KeyThemeName',
    'Gtk/ToolbarStyle',
    'Gtk/ToolbarIconSize',
    'Gtk/MenuImages',
    'Gtk/ButtonImages',
    'Gtk/MenuBarAccel',
}

local function trim(s)
   return s:gsub('^%s+', ''):gsub('%s+$', '')
end

local function split(str)
    local words = {}
    for word in str:gmatch('%S+') do
        table.insert(words, word)
    end
    return words
end

local function contains(list, x)
    for _, v in pairs(list) do
        if v == x then return true end
    end
    return false
end

local function parse_conf(file)
    local l_arr = {}
    local fh = io.open(file, 'r');

    for line in fh:lines() do
        local words = split(line)
        local first, rest
        if #words >= 2 and contains(valid_keys, words[1]) then
            first = trim(words[1])
            table.remove(words, 1)
            rest = trim(table.concat(words, ' '))
            l_arr[first] = rest:gsub('%"', '')
        end
    end

    fh:close()

    return l_arr
end

return parse_conf(paths.xsd_conf)
