local theme = require('beautiful')
local gears = require('gears')
local wibox = require('wibox')
local color_util = require('utils.colors')

local buttons = {}

function buttons.gtk(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        fg = theme.button_fg,
        bg = theme.button_bg,
        border_color = theme.button_border_color,
        border_width = theme.button_border_width,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, theme.border_radius)
        end,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_fg(theme.button_fg_hover)
        w:set_bg(theme.button_bg_hover)
        w:set_shape_border_color(theme.button_border_color_hover)
    end)

    container:connect_signal('button::press', function(w)
        w:set_fg(theme.button_fg_pressed)
        w:set_bg(theme.button_bg_pressed)
        w:set_shape_border_color(theme.button_border_color_pressed)
    end)

    container:connect_signal('button::release', function(w)
        w:set_fg(theme.button_fg)
        w:set_bg(theme.button_bg)
        w:set_shape_border_color(theme.button_border_color)
    end)

    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_fg(theme.button_fg)
        w:set_bg(theme.button_bg)
        w:set_shape_border_color(theme.button_border_color)
    end)

    return container
end

function buttons.gtk_hover(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        fg = theme.button_fg,
        bg = theme.transparent,
        border_color = theme.transparent,
        border_width = theme.button_border_width,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, theme.border_radius)
        end,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_fg(theme.button_fg_hover)
        w:set_bg(theme.button_bg_hover)
        w:set_shape_border_color(theme.button_border_color_hover)
    end)

    container:connect_signal('button::press', function(w)
        w:set_fg(theme.button_fg_pressed)
        w:set_bg(theme.button_bg_pressed)
        w:set_shape_border_color(theme.button_border_color_pressed)
    end)

    container:connect_signal('button::release', function(w)
        w:set_fg(theme.button_fg)
        w:set_bg(theme.button_bg)
        w:set_shape_border_color(theme.button_border_color)
    end)

    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_fg(theme.button_fg)
        w:set_bg(theme.transparent)
        w:set_shape_border_color(theme.transparent)
    end)

    return container
end

function buttons.header(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        fg = theme.header_fg,
        bg = theme.header_bg,
        border_color = theme.header_border_color,
        border_width = theme.button_border_width,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, theme.border_radius)
        end,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_fg(theme.header_fg_hover)
        w:set_bg(theme.header_bg_hover)
        w:set_shape_border_color(theme.header_border_color_hover)
    end)

    container:connect_signal('button::press', function(w)
        w:set_fg(theme.header_fg_pressed)
        w:set_bg(theme.header_bg_pressed)
        w:set_shape_border_color(theme.header_border_color_pressed)
    end)

    container:connect_signal('button::release', function(w)
        w:set_fg(theme.header_fg)
        w:set_bg(theme.header_bg)
        w:set_shape_border_color(theme.header_border_color)
    end)


    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_fg(theme.header_fg)
        w:set_bg(theme.header_bg)
        w:set_shape_border_color(theme.header_border_color)
    end)
    return container
end

function buttons.wibar(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        fg = theme.header_fg,
        bg = theme.transparent,
        border_color = theme.transparent,
        border_width = theme.button_border_width,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, theme.border_radius)
        end,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_fg(theme.header_fg_hover)
        w:set_bg(theme.header_bg_hover)
        w:set_shape_border_color(theme.header_border_color_hover)
    end)

    container:connect_signal('button::press', function(w)
        w:set_fg(theme.header_fg_pressed)
        w:set_bg(theme.header_bg_pressed)
        w:set_shape_border_color(theme.header_border_color_pressed)
    end)

    container:connect_signal('button::release', function(w)
        w:set_fg(theme.header_fg)
        w:set_bg(theme.transparent)
        w:set_shape_border_color(theme.transparent)
    end)

    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_fg(theme.header_fg)
        w:set_bg(theme.transparent)
        w:set_shape_border_color(theme.transparent)
    end)

    return container
end

function buttons.menu(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        fg = theme.header_fg,
        bg = theme.transparent,
        border_color = theme.transparent,
        border_width = theme.button_border_width,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, theme.border_radius)
        end,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_fg(theme.header_fg_hover)
        w:set_bg(theme.header_bg_hover)
        w:set_shape_border_color(color_util.mix(theme.bg_success, theme.base_fg, 0.8))
    end)

    container:connect_signal('button::press', function(w)
        w:set_fg(theme.header_fg_pressed)
        w:set_bg(theme.header_bg_pressed)
        w:set_shape_border_color(theme.header_border_color_pressed)
    end)

    container:connect_signal('button::release', function(w)
        w:set_fg(theme.header_fg)
        w:set_bg(theme.transparent)
        w:set_shape_border_color(theme.transparent)
    end)

    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_fg(theme.header_fg)
        w:set_bg(theme.transparent)
        w:set_shape_border_color(theme.transparent)
    end)

    return container
end

function buttons.tasklist(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        fg = theme.header_fg,
        bg = theme.header_bg,
        border_color = theme.header_border_color,
        border_width = theme.button_border_width,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, theme.border_radius)
        end,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_shape_border_color(theme.button_border_color_hover)
    end)

    container:connect_signal('button::press', function(w)
        w:set_fg(theme.header_fg_pressed)
        w:set_bg(theme.header_bg_pressed)
        w:set_shape_border_color(theme.header_border_color_pressed)
    end)

    container:connect_signal('button::release', function(w)
        w:set_fg(theme.header_fg)
        w:set_bg(theme.header_bg)
        w:set_shape_border_color(theme.header_border_color)
    end)

    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_fg(theme.header_fg)
        w:set_bg(theme.header_bg)
        w:set_shape_border_color(theme.header_border_color)
    end)

    return container
end

function buttons.taglist(contents)

    local container = wibox.widget {
        contents,
        widget = wibox.container.background,
        bg = theme.header_bg,
        border_color = theme.header_border_color,
        border_width = theme.button_border_width,
        shape = theme.taglist_shape,
    }

    local old_cursor, old_wibox

    container:connect_signal('mouse::enter', function(w)
        local cur_wibox = mouse.current_wibox
        old_cursor, old_wibox = cur_wibox.cursor, cur_wibox
        cur_wibox.cursor = 'hand1'
        w:set_shape_border_color(theme.button_border_color_hover)
    end)

    container:connect_signal('mouse::leave', function(w)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
        w:set_shape_border_color(theme.button_border_color)
    end)

    return container
end

return buttons
