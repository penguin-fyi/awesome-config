-- Session menu button
local awful     = require 'awful'
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local button = require 'widgets.buttons'.menu
local menu = require 'widgets.menus.session'
local get_position = require 'utils.common'.menus.get_position

local function session(args)

    args = args or {}
    args.session_icon     = args.session_icon     or beautiful.session_button_icon
    args.session_width    = args.session_width    or dpi(24)
    args.session_position = args.session_position or 'tr'
    args.session_tooltip  = args.session_tooltip  or 'Session'

    local mouse_buttons = {
        awful.button({ }, 1, nil, function()
            menu:toggle({coords=get_position(args.session_position)})
        end)
    }

    local widget = wibox.widget {
        widget = wibox.container.place,
        {
            widget  = button,
            buttons = mouse_buttons,
            {
                widget = awful.widget.button {
                    image  = args.session_icon,
                    resize = true,
                },
                forced_width = args.session_width,
                valign = 'center',
                halign = 'center',
            }
        }
    }

    if args.session_tooltip ~= nil then
        local tooltip = awful.tooltip {
            text = args.session_tooltip,
            align = 'bottom_left',
            delay_show = 1,
        }
        tooltip:add_to_object(widget)
    end

    return widget
end

return session
