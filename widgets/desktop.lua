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

    open_with   = 'xdg-open',
    font        = 'Sans 12',
    iconsize    = { width = 48,  height = 48 },
    labelsize   = { width = 96, height = 22 },
    margin      = { x = 20, y = 20 },
    padding     = 4,
    spacing     = 4,
    spawn_opt   = nil,
}

local current_pos = {}

local desktop = function(s, args)
    local args = args or {}
    local open_with  = args.open_with or defaults.open_with
    local font       = args.font or theme.font or defaults.font
    local icons      = args.icons or defaults.icons
    local iconsize   = args.iconsize or defaults.iconsize
    local labelsize  = args.labelsize or defaults.labelsize
    local margin     = args.margin or defaults.margin
    local padding    = args.padding or defaults.padding
    local spacing    = args.spacing or defaults.spacing
    local spawn_opt  = args.spawn_opt or defaults.spawn_opt

    local function add_icon(scr, icon, label, onclick)
        local dcp = current_pos

        if not dcp[scr] then
            dcp[scr] = {
                x = (screen[scr].geometry.x + (margin.x*2)),
                y = screen[scr].geometry.y + theme.wibar_height + margin.y
            }
        end

        local tot_height = (icon and iconsize.height or 0)
                            + (label and labelsize.height or 0)
                            + (padding*4)
                            + spacing
        if tot_height == 0 then return end

        if dcp[scr].y + tot_height > screen[scr].geometry.y + screen[scr].geometry.height - 10 - margin.y then
            dcp[scr].x = dcp[scr].x + iconsize.width + margin.x
            dcp[scr].y = 10 + margin.y
        end

        local container = wibox {
            screen      = s,
            type        = 'desktop',
            visible     = true,
            ontop       = false,
            width       = labelsize.width + (padding*2),
            height      = iconsize.height + labelsize.height
                            + (padding*4) + 2,
            x           = dcp[scr].x,
            y           = dcp[scr].y,
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
                                    forced_width = iconsize.width,
                                    forced_height = iconsize.height,
                                    widget  = wibox.widget.imagebox
                                },
                                widget = wibox.container.margin,
                                margins = padding,
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
                                    font    = font,
                                    align   = 'center',
                                    widget  = wibox.widget.textbox
                                },
                                widget = wibox.container.margin,
                                margins = padding,
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
                margins = spacing,
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

        dcp[scr].y = dcp[scr].y + iconsize.height + labelsize.height +
            (padding*4) + spacing

        current_pos = dcp

        return dcp
    end

    for _, item in ipairs(icons) do
        add_icon(s, lookup_icon(item.icon), item.label, function()
            awful.spawn(string.format('%s "%s"', open_with, item.onclick), spawn_opt)
        end)
    end
end

return desktop
