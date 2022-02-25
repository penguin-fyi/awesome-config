local awful = require('awful')
local theme = require("beautiful")
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')
local container = require('widgets.buttons').taglist

local mod = _G.cfg.modkey

local _M = function(s)
    s = s or screen.focused()

    local buttons = {
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ mod.super }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ mod.super }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
    }

    local layout = {
        spacing_widget = {
            {
                widget        = wibox.widget.separator,
                thickness     = theme.button_border_width,
                color         = theme.button_border_color,
            },
            widget = wibox.container.place,
            valign = "center",
            halign = "center",
        },
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(1),
    }

    local template = {
        {
            wibox.widget.base.make_widget(),
            widget = wibox.container.background,
            forced_height = dpi(2),
        },
        {
            {
                {
                    widget = wibox.widget.textbox,
                    id = 'index_role',
                },
                {
                    widget = wibox.widget.textbox,
                    id = 'text_role',
                    align = 'center',
                },
                layout = wibox.layout.fixed.horizontal,
                fill_space = true,
            },
            widget = wibox.container.margin,
            left = dpi(6),
            right = dpi(6),
        },
        {
            wibox.widget.base.make_widget(),
            widget = wibox.container.background,
            id = 'background_role',
            forced_height = dpi(2),
        },
        layout = wibox.layout.align.vertical,
    }

    local taglist_widget = wibox.widget {
        awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            layout = layout,
            buttons = buttons,
            widget_template = template,
        },
        widget = container,
    }

    return taglist_widget
end

return _M
