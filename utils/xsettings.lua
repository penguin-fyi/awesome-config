local default_conf = os.getenv('HOME')..'/.xsettingsd.conf'

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

    if fh then
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
    end

    return l_arr
end

local function init_xsettings(args)
    args = args or {}

    local path = args.path or default_conf
    _G.xsettings = parse_conf(path)
end

return init_xsettings
