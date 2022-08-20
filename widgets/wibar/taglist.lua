-- Taglist
local awful     = require 'awful'
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local container = require 'widgets.buttons'.taglist

local mod = require 'config.modkeys'

local function taglist(s, args)

    args = args or {}

    local mouse_buttons = {
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
                thickness     = beautiful.button_border_width,
                color         = beautiful.button_border_color,
            },
            widget = wibox.container.place,
            valign = 'center',
            halign = 'center',
        },
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(1),
    }

    local template = {
        layout = wibox.layout.align.vertical,
        {
            widget = wibox.container.background,
            forced_height = dpi(2),
            wibox.widget.base.make_widget(),
        },
        {
            {
                layout = wibox.layout.fixed.horizontal,
                fill_space = true,
                {
                    widget = wibox.widget.textbox,
                    id     = 'index_role',
                },
                {
                    widget = wibox.widget.textbox,
                    id     = 'text_role',
                    align  = 'center',
                }
            },
            widget = wibox.container.margin,
            left   = dpi(6),
            right  = dpi(6),
        },
        {
            widget = wibox.container.background,
            id     = 'background_role',
            forced_height = dpi(2),
            wibox.widget.base.make_widget(),
        }
    }

    local widget = wibox.widget {
        widget = wibox.container.place,
        {
            widget = container,
            awful.widget.taglist {
                screen  = s,
                filter  = awful.widget.taglist.filter.all,
                layout = layout,
                buttons = mouse_buttons,
                widget_template = template,
            }
        }
    }

    return widget
end

return taglist
