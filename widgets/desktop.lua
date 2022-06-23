-- awesome-freedesktop desktop
-- https://github.com/lcpz/awesome-freedesktop/blob/master/desktop.lua

local awful  = require('awful')
local theme  = require('beautiful')
local wibox  = require('wibox')

local lookup_icon = require('utils.icon_finder').lookup

local defaults = {
    icons = {
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
    },

    iconsize    = { width = 48,  height = 48 },
    labelsize   = { width = 96, height = 22 },
    margin      = { x = 20, y = 20, icon = 4, label = 4 },
    spacing     = 4,
}

local current_pos = {}

local desktop = function(args)
    args            = args or {}
    args.screen     = args.screen or mouse.screen
    args.open_with  = args.open_with or 'xdg-open'
    args.icons      = args.icons or defaults.icons
    args.iconsize   = args.iconsize or defaults.iconsize
    args.labelsize  = args.labelsize or defaults.labelsize
    args.margin     = args.margin or defaults.margin
    args.spacing    = args.spacing or defaults.spacing

    local function add_icon(s, icon, label, onclick)
        local dcp = current_pos

        if not dcp[s] then
            dcp[s] = {
                x = (screen[s].geometry.x + (args.margin.x*2)),
                y = screen[s].geometry.y + theme.wibar_height + args.margin.y
            }
        end

        local tot_height = (icon and args.iconsize.height or 0) + (label and args.labelsize.height or 0)
        if tot_height == 0 then return end

        if dcp[s].y + tot_height > screen[s].geometry.y + screen[s].geometry.height - 10 - args.margin.y then
            dcp[s].x = dcp[s].x + args.iconsize.width + args.margin.x
            dcp[s].y = 10 + args.margin.y
        end

        local container = wibox {
            screen      = s,
            type        = 'desktop',
            visible     = true,
            ontop       = false,
            width       = args.labelsize.width + 4,
            height      = args.iconsize.height + args.labelsize.height
                            + (args.margin.icon*2) + (args.margin.label*2) + 2,
            x           = dcp[s].x,
            y           = dcp[s].y,
            fg          = theme.fg_normal,
            bg          = theme.transparent,
            shape       = theme.button_shape,
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
                                margins = args.margin.icon,
                            },
                            id = 'icon_bg',
                            widget = wibox.container.background,
                            shape = theme.button_shape,
                        },
                        widget = wibox.container.place,
                    },
                    {
                        {
                            {
                                {
                                    text    = label,
                                    align   = 'center',
                                    widget  = wibox.widget.textbox
                                },
                                widget = wibox.container.margin,
                                margins = args.margin.label,
                            },
                            id = 'label_bg',
                            widget = wibox.container.background,
                            shape = theme.button_shape,
                        },
                        widget = wibox.container.place,
                    },
                    layout = wibox.layout.fixed.vertical,
                    spacing = 2,
                },
                widget = wibox.container.margin,
                margins = args.spacing,
            },
            widget = wibox.container.background,
            bg = theme.transparent,
        }

        local icon_bg = container:get_children_by_id('icon_bg')[1]
        local label_bg = container:get_children_by_id('label_bg')[1]

        container:connect_signal('mouse::enter', function()
            icon_bg:set_bg(theme.osd_bg)
            label_bg:set_bg(theme.osd_bg)
        end)

        container:connect_signal('mouse::leave', function()
            icon_bg:set_bg(theme.transparent)
            label_bg:set_bg(theme.transparent)
        end)

        container:buttons(awful.button({ }, 1, nil, onclick))

        dcp[s].y = dcp[s].y + args.iconsize.height + args.labelsize.height +
            (args.margin.icon*2) + (args.margin.label*2) + args.spacing

        current_pos = dcp

        return dcp
    end

    for _,base in ipairs(args.icons) do
        add_icon(args.screen, lookup_icon(base.icon), base.label, function()
            awful.spawn(string.format('%s "%s"', args.open_with, base.onclick))
        end)
    end
end

return desktop
