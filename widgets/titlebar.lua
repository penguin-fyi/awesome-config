local awful     = require 'awful'
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi = beautiful.xresources.apply_dpi

local function titlebar(c, args)

    args = args or {}
    args.width    = args.width    or beautiful.titlebar_width  or dpi(0)
    args.height   = args.height   or beautiful.titlebar_height or dpi(24)
    if args.tooltips == nil then args.tooltips = false end

    local top    = awful.titlebar(c, { size = dpi(args.height), position = 'top'    })
    local left   = awful.titlebar(c, { size = dpi(args.width),  position = 'left'   })
    local right  = awful.titlebar(c, { size = dpi(args.width),  position = 'right'  })
    local bottom = awful.titlebar(c, { size = dpi(args.width),  position = 'bottom' })

    awful.titlebar.enable_tooltip = args.tooltips

    local mouse_buttons = {
        awful.button({ }, 1, function()
            c:activate {context='titlebar', action='mouse_move'}
        end),
        awful.button({ }, 3, function()
            c:activate {context='titlebar', action='mouse_resize'}
        end),
    }

    top:setup {
        widget  = wibox.container.margin,
        margins = {
            left   = dpi(4),
            right  = dpi(4),
            top    = dpi(2),
            bottom = dpi(2),
        },
        {
            layout = wibox.layout.align.horizontal,
            {
                layout  = wibox.layout.fixed.horizontal,
                spacing = dpi(4),
                awful.titlebar.widget.stickybutton(c),
                awful.titlebar.widget.ontopbutton(c),
            },
            {
                widget = wibox.container.place,
                buttons = mouse_buttons,
                {
                    layout  = wibox.layout.fixed.horizontal,
                    spacing = dpi(4),
                    awful.titlebar.widget.iconwidget(c),
                    awful.titlebar.widget.titlewidget(c),
                }
            },
            {
                layout  = wibox.layout.fixed.horizontal,
                spacing = dpi(4),
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
            }
        }
    }

    left:setup {
        layout = wibox.layout.flex.horizontal,
        {
            widget  = wibox.container.background,
            buttons = mouse_buttons,
        }
    }

    right:setup {
        layout = wibox.layout.flex.horizontal,
        {
            widget  = wibox.container.background,
            buttons = mouse_buttons,
        }
    }

    bottom:setup {
        layout = wibox.layout.flex.vertical,
        {
            widget  = wibox.container.background,
            buttons = mouse_buttons,
        }
    }

end

return titlebar
