-- Awesome
local theme = require('beautiful')

-- Global
local cfg_vars = _G.cfg.vars or nil

-- Local
local vars = {}
vars.fg     = cfg_vars.rofi_fg      or theme.fg_normal
vars.bg     = cfg_vars.rofi_bg      or theme.bg_normal
vars.focus  = cfg_vars.rofi_focus   or theme.bg_focus
vars.width  = cfg_vars.rofi_width   or theme.menu_width*2
vars.radius = cfg_vars.rofi_radius  or theme.border_radius
vars.font   = cfg_vars.rofi_font    or theme.font

local paths = {}
paths.theme_file = os.getenv('XDG_CONFIG_HOME')..'/rofi/themes/awesome.rasi'

local data_str = [[
* {
    fg: ##FG##;
    bg: ##BG##;
    focus: ##FOCUS##;
    background-color: @bg;
    text-color: @fg;
    margin: 0;
    padding: 0;
    spacing: 0;
}

window {
    width: ##WIDTH##px;
    font: "##FONT##";
    border-radius: ##RADIUS##;
}

mainbox {
    children: [inputbar, listview];
}

inputbar {
    children: [prompt, entry];
}

entry {
  background-color: inherit;
  padding: 4px 0px;
}

prompt {
  background-color: inherit;
  padding: 4px;
}

listview {
  lines: 8;
}

element {
  children: [element-icon, element-text];
}

element-icon {
  padding: 4px 4px;
}

element-icon selected {
  padding: 10px 10px;
  background-color: @focus;
}

element-text {
  padding: 4px 0;
  text-color: inherit;
}

element-text selected {
  text-color: @bg;
  background-color: @focus;
}

]]

local _M = function()
    for k, v in pairs(vars) do
        data_str = data_str:gsub('##'..string.upper(k)..'##', v)
    end

    local file = assert(io.open(paths.theme_file, "w+"))
    file:write(data_str)
    file:close()
end

return _M
