local _color = {}

_color.hex_color_match = "[a-fA-F0-9][a-fA-F0-9]"

function _color.darker(color_value, darker_n)
    local result = "#"
    local channel_counter = 1
    for s in color_value:gmatch(_color.hex_color_match) do
        local bg_numeric_value = tonumber("0x"..s)
        if channel_counter <= 3 then
            bg_numeric_value = bg_numeric_value - darker_n
        end
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%02x", bg_numeric_value)
        channel_counter = channel_counter + 1
    end
    return result
end

function _color.is_dark(color_value)
    local bg_numeric_value = 0;
    local channel_counter = 1
    for s in color_value:gmatch(_color.hex_color_match) do
        bg_numeric_value = bg_numeric_value + tonumber("0x"..s);
        if channel_counter == 3 then
            break
        end
        channel_counter = channel_counter + 1
    end
    local is_dark_bg = (bg_numeric_value < 383)
    return is_dark_bg
end

function _color.mix(color1, color2, ratio)
    ratio = ratio or 0.5
    local result = "#"
    local channels1 = color1:gmatch(_color.hex_color_match)
    local channels2 = color2:gmatch(_color.hex_color_match)
    for _ = 1,3 do
        local bg_numeric_value = math.ceil(
          tonumber("0x"..channels1())*ratio +
          tonumber("0x"..channels2())*(1-ratio)
        )
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%02x", bg_numeric_value)
    end
    return result
end

function _color.reduce_contrast(color, ratio)  -- luacheck: no unused
    ratio = ratio or 50
    return _color.darker(color, _color.is_dark(color) and -ratio or ratio)
end

function _color.choose_contrast_color(reference, candidate1, candidate2)  -- luacheck: no unused
    if _color.is_dark(reference) then
        if not _color.is_dark(candidate1) then
            return candidate1
        else
            return candidate2
        end
    else
        if _color.is_dark(candidate1) then
            return candidate1
        else
            return candidate2
        end
    end
end

return _color
