local beautiful = require 'beautiful'

local theme_path = os.getenv('XDG_CONFIG_HOME')..'/rofi/themes/awesome.rasi'

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
    border: ##BORDER##;
    border-color: ##BORDER_COLOR##;
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

local function theme_rofi(args, style)

    args = args or {}
    args.path     = args.path     or theme_path
    args.template = args.template or theme_template

    style = style or {}
    style.fg     = style.fg     or beautiful.rofi_fg
    style.bg     = style.bg     or beautiful.rofi_bg
    style.focus  = style.focus  or beautiful.rofi_focus
    style.width  = style.width  or beautiful.rofi_width
    style.radius = style.radius or beautiful.rofi_radius
    style.font   = style.font   or beautiful.rofi_font
    style.border = style.border or beautiful.rofi_border
    style.border_color = style.border_color or beautiful.rofi_border_color

    -- sub ##KEY## for value
    for k, v in pairs(style) do
        args.template = args.template:gsub('##'..string.upper(k)..'##', v)
    end

    local file = assert(io.open(args.path, 'w+'))
    file:write(args.template)
    file:close()
end

return theme_rofi
