local beautiful = require 'beautiful'
local gears     = require 'gears'
local wibox     = require 'wibox'

local colors = require 'utils.common'.colors

local buttons = {}

function buttons.gtk(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        fg = beautiful.button_fg,
        bg = beautiful.button_bg,
        border_color = beautiful.button_border_color,
        border_width = beautiful.button_border_width,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
        end,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        if not cur_wibox then return end
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_fg(beautiful.button_fg_hover)
        w:set_bg(beautiful.button_bg_hover)
        w:set_shape_border_color(beautiful.button_border_color_hover)
    end)

    container:connect_signal('button::press', function(w)
        w:set_fg(beautiful.button_fg_pressed)
        w:set_bg(beautiful.button_bg_pressed)
        w:set_shape_border_color(beautiful.button_border_color_pressed)
    end)

    container:connect_signal('button::release', function(w)
        w:set_fg(beautiful.button_fg)
        w:set_bg(beautiful.button_bg)
        w:set_shape_border_color(beautiful.button_border_color)
    end)

    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_fg(beautiful.button_fg)
        w:set_bg(beautiful.button_bg)
        w:set_shape_border_color(beautiful.button_border_color)
    end)

    return container
end

function buttons.gtk_hover(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        fg = beautiful.button_fg,
        bg = beautiful.transparent,
        border_color = beautiful.transparent,
        border_width = beautiful.button_border_width,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
        end,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        if not cur_wibox then return end
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_fg(beautiful.button_fg_hover)
        w:set_bg(beautiful.button_bg_hover)
        w:set_shape_border_color(beautiful.button_border_color_hover)
    end)

    container:connect_signal('button::press', function(w)
        w:set_fg(beautiful.button_fg_pressed)
        w:set_bg(beautiful.button_bg_pressed)
        w:set_shape_border_color(beautiful.button_border_color_pressed)
    end)

    container:connect_signal('button::release', function(w)
        w:set_fg(beautiful.button_fg)
        w:set_bg(beautiful.button_bg)
        w:set_shape_border_color(beautiful.button_border_color)
    end)

    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_fg(beautiful.button_fg)
        w:set_bg(beautiful.transparent)
        w:set_shape_border_color(beautiful.transparent)
    end)

    return container
end

function buttons.header(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        fg = beautiful.header_fg,
        bg = beautiful.header_bg,
        border_color = beautiful.header_border_color,
        border_width = beautiful.button_border_width,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
        end,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        if not cur_wibox then return end
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_fg(beautiful.header_fg_hover)
        w:set_bg(beautiful.header_bg_hover)
        w:set_shape_border_color(beautiful.header_border_color_hover)
    end)

    container:connect_signal('button::press', function(w)
        w:set_fg(beautiful.header_fg_pressed)
        w:set_bg(beautiful.header_bg_pressed)
        w:set_shape_border_color(beautiful.header_border_color_pressed)
    end)

    container:connect_signal('button::release', function(w)
        w:set_fg(beautiful.header_fg)
        w:set_bg(beautiful.header_bg)
        w:set_shape_border_color(beautiful.header_border_color)
    end)


    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_fg(beautiful.header_fg)
        w:set_bg(beautiful.header_bg)
        w:set_shape_border_color(beautiful.header_border_color)
    end)
    return container
end

function buttons.wibar(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        fg = beautiful.header_fg,
        bg = beautiful.transparent,
        border_color = beautiful.transparent,
        border_width = beautiful.button_border_width,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
        end,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        if not cur_wibox then return end
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_fg(beautiful.header_fg_hover)
        w:set_bg(beautiful.header_bg_hover)
        w:set_shape_border_color(beautiful.header_border_color_hover)
    end)

    container:connect_signal('button::press', function(w)
        w:set_fg(beautiful.header_fg_pressed)
        w:set_bg(beautiful.header_bg_pressed)
        w:set_shape_border_color(beautiful.header_border_color_pressed)
    end)

    container:connect_signal('button::release', function(w)
        w:set_fg(beautiful.header_fg)
        w:set_bg(beautiful.transparent)
        w:set_shape_border_color(beautiful.transparent)
    end)

    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_fg(beautiful.header_fg)
        w:set_bg(beautiful.transparent)
        w:set_shape_border_color(beautiful.transparent)
    end)

    return container
end

function buttons.menu(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        fg = beautiful.header_fg,
        bg = beautiful.transparent,
        border_color = beautiful.transparent,
        border_width = beautiful.button_border_width,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
        end,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        if not cur_wibox then return end
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_fg(beautiful.header_fg_hover)
        w:set_bg(beautiful.header_bg_hover)
        w:set_shape_border_color(colors.mix(beautiful.bg_success, beautiful.base_fg, 0.8))
    end)

    container:connect_signal('button::press', function(w)
        w:set_fg(beautiful.header_fg_pressed)
        w:set_bg(beautiful.header_bg_pressed)
        w:set_shape_border_color(beautiful.header_border_color_pressed)
    end)

    container:connect_signal('button::release', function(w)
        w:set_fg(beautiful.header_fg)
        w:set_bg(beautiful.transparent)
        w:set_shape_border_color(beautiful.transparent)
    end)

    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_fg(beautiful.header_fg)
        w:set_bg(beautiful.transparent)
        w:set_shape_border_color(beautiful.transparent)
    end)

    return container
end

function buttons.tasklist(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        fg = beautiful.header_fg,
        bg = beautiful.header_bg,
        border_color = beautiful.header_border_color,
        border_width = beautiful.button_border_width,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
        end,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        if not cur_wibox then return end
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_shape_border_color(beautiful.button_border_color_hover)
    end)

    container:connect_signal('button::press', function(w)
        w:set_fg(beautiful.header_fg_pressed)
        w:set_bg(beautiful.header_bg_pressed)
        w:set_shape_border_color(beautiful.header_border_color_pressed)
    end)

    container:connect_signal('button::release', function(w)
        w:set_fg(beautiful.header_fg)
        w:set_bg(beautiful.header_bg)
        w:set_shape_border_color(beautiful.header_border_color)
    end)

    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_fg(beautiful.header_fg)
        w:set_bg(beautiful.header_bg)
        w:set_shape_border_color(beautiful.header_border_color)
    end)

    return container
end

function buttons.taglist(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        bg = beautiful.header_bg,
        border_color = beautiful.header_border_color,
        border_width = beautiful.button_border_width,
        shape = beautiful.taglist_shape,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        if not cur_wibox then return end
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_shape_border_color(beautiful.button_border_color_hover)
    end)

    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_shape_border_color(beautiful.button_border_color)
    end)

    return container
end

return buttons
