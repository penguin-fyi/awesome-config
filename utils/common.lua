local awful = require('awful')
local theme = require('beautiful')
local cairo = require('lgi').cairo
local rsvg = require('lgi').Rsvg

local menu_utils = {}

-- Get geometry to position menu at corner
function menu_utils.get_position(corner)
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

    -- Top left
    if corner == 'tl' then
        return { x = 0, y = 0 }
    -- Top right
    elseif corner == 'tr' then
        return { x = width-total_width, y = 0 }
    -- Bottom left
    elseif corner == 'bl' then
        return { x = 0, y = height }
    -- Bottom right
    elseif corner == 'br' then
        return { x = width-total_width, y = height }
    end
end

-- /usr/share/awesome/themes/gtk/theme.lua
local color_utils = {}

color_utils.hex_color_match = '[a-fA-F0-9][a-fA-F0-9]'

function color_utils.darker(color_value, darker_n)
    local result = '#'
    local channel_counter = 1
    for s in color_value:gmatch(color_utils.hex_color_match) do
        local bg_numeric_value = tonumber('0x'..s)
        if channel_counter <= 3 then
            bg_numeric_value = bg_numeric_value - darker_n
        end
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format('%02x', bg_numeric_value)
        channel_counter = channel_counter + 1
    end
    return result
end

function color_utils.is_dark(color_value)
    local bg_numeric_value = 0;
    local channel_counter = 1
    for s in color_value:gmatch(color_utils.hex_color_match) do
        bg_numeric_value = bg_numeric_value + tonumber('0x'..s);
        if channel_counter == 3 then
            break
        end
        channel_counter = channel_counter + 1
    end
    local is_dark_bg = (bg_numeric_value < 383)
    return is_dark_bg
end

function color_utils.mix(color1, color2, ratio)
    ratio = ratio or 0.5
    local result = '#'
    local channels1 = color1:gmatch(color_utils.hex_color_match)
    local channels2 = color2:gmatch(color_utils.hex_color_match)
    for _ = 1,3 do
        local bg_numeric_value = math.ceil(
          tonumber('0x'..channels1())*ratio +
          tonumber('0x'..channels2())*(1-ratio)
        )
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format('%02x', bg_numeric_value)
    end
    return result
end

function color_utils.reduce_contrast(color, ratio)
    ratio = ratio or 50
    return color_utils.darker(color, color_utils.is_dark(color) and -ratio or ratio)
end

function color_utils.choose_contrast_color(reference, candidate1, candidate2)
    if color_utils.is_dark(reference) then
        if not color_utils.is_dark(candidate1) then
            return candidate1
        else
            return candidate2
        end
    else
        if color_utils.is_dark(candidate1) then
            return candidate1
        else
            return candidate2
        end
    end
end

local svg_utils = {}

-- Render SVG from string
function svg_utils.new_from_str(data, color, replace, size)
    if not data then return end
    color = color or nil
    replace = replace or '#ffffff'
    size = size or 16
    local surface = cairo.ImageSurface(cairo.Format.ARGB32, size, size)
    local context = cairo.Context(surface)
    if color then
        data = string.gsub(data, replace, color)
    end
    rsvg.Handle.new_from_data(data):render_cairo(context)
    return surface
end

-- Render SVG from file
function svg_utils.new_from_file(file, size)
    if not file then return end
    size = size or 16
    local surface = cairo.ImageSurface(cairo.Format.ARGB32, size, size)
    local context = cairo.Context(surface)
    rsvg.Handle.new_from_file(file):render_cairo(context)
    return surface
end

return {
    colors = color_utils,
    menus = menu_utils,
    svg = svg_utils,
}
