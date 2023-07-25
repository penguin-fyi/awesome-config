local awful     = require 'awful'
local beautiful = require 'beautiful'
local dpi       = beautiful.xresources.apply_dpi
local gears     = require 'gears'
local rounded   = gears.shape.rounded_rect
local wibox     = require 'wibox'

local function titlebar(c, args)

    args = args or {}
    args.width    = args.width    or beautiful.titlebar_width  or dpi(2)
    args.height   = args.height   or beautiful.titlebar_height or dpi(20)
    args.radius   = args.radius   or beautiful.titlebar_radius or 0
    args.fade     = args.fade     or beautiful.titlebar_unfocus_fade or 1
    if args.tooltips == nil then args.tooltips = false end

    awful.titlebar.enable_tooltip = args.tooltips

    local sides = {
      top    = awful.titlebar(c, { size = dpi(args.height), position = 'top'    }),
      left   = awful.titlebar(c, { size = dpi(args.width),  position = 'left'   }),
      right  = awful.titlebar(c, { size = dpi(args.width),  position = 'right'  }),
      bottom = awful.titlebar(c, { size = dpi(args.width+2),  position = 'bottom' }),
    }

    local buttons = {
      sticky    = awful.titlebar.widget.stickybutton(c),
      ontop     = awful.titlebar.widget.ontopbutton(c),
      minimize  = awful.titlebar.widget.minimizebutton(c),
      maximize  = awful.titlebar.widget.maximizedbutton(c),
      close     = awful.titlebar.widget.closebutton(c),
    }

    local title = {
      icon  = awful.titlebar.widget.iconwidget(c),
      text  = awful.titlebar.widget.titlewidget(c),
    }

    local mouse_buttons = {
        awful.button({ }, 1, function()
            c:activate {context='titlebar', action='mouse_move'}
        end),
        awful.button({ }, 3, function()
            c:activate {context='titlebar', action='mouse_resize'}
        end),
    }

    sides.top:setup {
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
                buttons.sticky,
                buttons.ontop,
            },
            {
                widget = wibox.container.place,
                buttons = mouse_buttons,
                {
                    layout  = wibox.layout.fixed.horizontal,
                    spacing = dpi(4),
                    title.icon,
                    title.text,
                }
            },
            {
                layout  = wibox.layout.fixed.horizontal,
                spacing = dpi(4),
                buttons.minimize,
                buttons.maximize,
                buttons.close,
            }
        }
    }

    sides.left:setup {
        layout = wibox.layout.flex.horizontal,
        {
            widget  = wibox.container.background,
            buttons = mouse_buttons,
        }
    }

    sides.right:setup {
        layout = wibox.layout.flex.horizontal,
        {
            widget  = wibox.container.background,
            buttons = mouse_buttons,
        }
    }

    sides.bottom:setup {
        layout = wibox.layout.flex.vertical,
        {
            widget  = wibox.container.background,
            buttons = mouse_buttons,
        }
    }

    c.shape = function(cr, w, h)
        rounded(cr, w, h, args.radius)
    end

  if args.fade < 1 then
    c:connect_signal('focus', function()
      for _, b in pairs(buttons) do b.opacity = 1.0 end
      for _, t in pairs(title) do t.opacity = 1.0 end
    end)

    c:connect_signal('unfocus', function()
      for _, b in pairs(buttons) do b.opacity = args.fade end
      for _, t in pairs(title) do t.opacity = args.fade end
    end)
  end
end

return titlebar
