local theme = require('beautiful')
local join = require('gears.table').join

local default_paths = {
    rofi_theme_file = os.getenv('XDG_CONFIG_HOME')..'/rofi/themes/awesome.rasi'
}
local user_paths = require('config.paths')
local paths = join(default_paths, user_paths)

local theme_vars = {
    fg     = theme.rofi_fg,
    bg     = theme.rofi_bg,
    focus  = theme.rofi_focus,
    width  = theme.rofi_width,
    radius = theme.rofi_radius,
    font   = theme.rofi_font,
}

local theme_template = [[
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

local function write_theme(template, vars, output)
    template = template or theme_template
    vars = vars or theme_vars
    output = output or paths.rofi_theme_file

    -- sub ##KEY## for value
    for k, v in pairs(vars) do
        template = template:gsub('##'..string.upper(k)..'##', v)
    end

    local file = assert(io.open(output, 'w+'))
    file:write(template)
    file:close()
end

return write_theme
