local awful = require('awful')
local theme = require('beautiful')
local dpi = require("beautiful.xresources").apply_dpi
local gears = require('gears')
local timer = gears.timer
local wibox = require('wibox')
local container = require('widgets.buttons').wibar

local mod = _G.cfg.modkey

local cfg_vars = _G.cfg.vars or nil

local vars = {}
vars.systray_autohide = cfg_vars.topbar_systray_autohide or false

local _M = function()

    local systray = wibox.widget {
        {
            widget = wibox.widget.systray
        },
        widget = wibox.container.margin,
        left = theme.systray_icon_spacing,
        visible = true,
    }

    local toggle_widget = wibox.widget {
        {
            {
                id = 'icon',
                widget = wibox.widget.imagebox,
                image = theme.systray_visible_icon,
                resize = true,
            },
            widget = wibox.container.margin,
            margins = dpi(2),
        },
        widget = container,
    }

    local systray_widget = wibox.widget {
        toggle_widget,
        systray,
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(2),
    }

    local create_hide_timer = function()
        if vars.systray_autohide then
            local timeout = tonumber(vars.systray_autohide)
            timer.start_new(timeout, function()
                toggle_widget:emit_signal("systray_toggle")
            end)
        end
    end

    toggle_widget:connect_signal("systray_toggle", function(self)
        local icon = self:get_children_by_id('icon')[1]
        systray.visible = not systray.visible
        if systray.visible then
            icon:set_image(theme.systray_visible_icon)
            create_hide_timer()
        else
            icon:set_image(theme.systray_hidden_icon)
        end
    end)

    toggle_widget:buttons(gears.table.join(
        awful.button({}, 1, nil, function()
            toggle_widget:emit_signal("systray_toggle")
        end)
    ))

    awful.keyboard.append_global_keybindings({
        awful.key({ mod.super, mod.alt }, 's', function()
            toggle_widget:emit_signal("systray_toggle")
        end,
        {description = 'toggle systray', group = 'awesome'})
    })

    if vars.systray_autohide then
        toggle_widget:emit_signal("systray_toggle")
    end

    return awful.widget.only_on_screen(systray_widget, 'primary')
end

return _M
