-- awesome-freedesktop desktop
-- https://github.com/lcpz/awesome-freedesktop/blob/master/desktop.lua
local awful     = require 'awful'
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi       = beautiful.xresources.apply_dpi

local find_icon = require 'utils.icon_finder'.lookup

local default_icons = {
    [1] = {
        label = 'Computer',
        icon  = 'computer',
        onclick = 'computer://'
    },
    [2] = {
        label = 'Home',
        icon  = 'user-home',
        onclick = os.getenv('HOME')
    },
    [3] = {
        label = 'Trash',
        icon  = 'user-trash',
        onclick = 'trash://'
    }
}

local current_pos = {}

local desktop = function(s, args)

    args = args or {}
    args.open_with  = args.open_with or 'xdg-open'
    args.font       = args.font      or beautiful.font or 'Sans 12'
    args.icons      = args.icons     or default_icons
    args.iconsize   = args.iconsize  or { width = 48,  height = 48 }
    args.labelsize  = args.labelsize or { width = 96, height = 22 }
    args.margin     = args.margin    or { x = 20, y = 20 }
    args.padding    = args.padding   or dpi(4)
    args.spacing    = args.spacing   or dpi(4)
    args.spawn_opt  = args.spawn_opt or nil

    local function add_icon(scr, icon, label, onclick)
        local dcp = current_pos

        if not dcp[scr] then
            dcp[scr] = {
                x = (screen[scr].geometry.x + (args.margin.x*2)),
                y = screen[scr].geometry.y + beautiful.wibar_height + args.margin.y
            }
        end

        local tot_height = (icon and args.iconsize.height or 0)
                            + (label and args.labelsize.height or 0)
                            + (args.padding*4)
                            + args.spacing
        if tot_height == 0 then return end

        if dcp[scr].y + tot_height > screen[scr].geometry.y + screen[scr].geometry.height - dpi(10) - args.margin.y then
            dcp[scr].x = dcp[scr].x + args.iconsize.width + args.margin.x
            dcp[scr].y = dpi(10) + args.margin.y
        end

        local container = wibox {
            screen      = s,
            type        = 'desktop',
            visible     = true,
            ontop       = false,
            width       = args.labelsize.width + (args.padding*2),
            height      = args.iconsize.height + args.labelsize.height
                            + (args.padding*4) + dpi(2),
            x           = dcp[scr].x,
            y           = dcp[scr].y,
            fg          = beautiful.fg_normal,
            bg          = beautiful.transparent,
            shape       = beautiful.button_shape,
        }

        container:setup {
            {
                {
                    {
                        {
                            {
                                {
                                    image   = icon,
                                    resize  = true,
                                    forced_width = args.iconsize.width,
                                    forced_height = args.iconsize.height,
                                    widget  = wibox.widget.imagebox
                                },
                                widget = wibox.container.margin,
                                margins = args.padding,
                            },
                            id = 'icon_bg',
                            widget = wibox.container.background,
                            shape = beautiful.button_shape,
                        },
                        widget = wibox.container.place,
                    },
                    {
                        {
                            {
                                {
                                    text    = label,
                                    font    = args.font,
                                    align   = 'center',
                                    widget  = wibox.widget.textbox
                                },
                                widget = wibox.container.margin,
                                margins = args.padding,
                            },
                            id = 'label_bg',
                            widget = wibox.container.background,
                            shape = beautiful.button_shape,
                        },
                        widget = wibox.container.place,
                    },
                    layout = wibox.layout.fixed.vertical,
                    spacing = dpi(2),
                },
                widget = wibox.container.margin,
                margins = args.spacing,
            },
            widget = wibox.container.background,
            bg = beautiful.transparent,
        }

        local icon_bg = container:get_children_by_id('icon_bg')[1]
        local label_bg = container:get_children_by_id('label_bg')[1]

        container:connect_signal('mouse::enter', function()
            icon_bg:set_bg(beautiful.osd_bg)
            label_bg:set_bg(beautiful.osd_bg)
        end)

        container:connect_signal('mouse::leave', function()
            icon_bg:set_bg(beautiful.transparent)
            label_bg:set_bg(beautiful.transparent)
        end)

        container:buttons(awful.button({ }, 1, nil, onclick))

        dcp[scr].y = dcp[scr].y + args.iconsize.height + args.labelsize.height +
            (args.padding*4) + args.spacing

        current_pos = dcp

        return dcp
    end

    for _, item in ipairs(args.icons) do
        add_icon(s, find_icon(item.icon), item.label, function()
            awful.spawn(string.format('%s "%s"', args.open_with, item.onclick), args.spawn_opt)
        end)
    end
end

return desktop
