local awful     = require 'awful'
local spawn     = awful.spawn
local beautiful = require 'beautiful'
local wibox     = require 'wibox'

local dpi       = beautiful.xresources.apply_dpi

local button    = require 'widgets.buttons'.gtk

local function session(s, args)

    args = args or {}
    args.timeout = args.timeout     or 10
    if args.timeout_run == nil then args.timeout_run = false end
    if args.backdrop == nil then args.backdrop = true end

    args.confirm_icon = args.confirm_icon or beautiful.session_confirm_icon
    args.cancel_icon  = args.cancel_icon  or beautiful.session_cancel_icon

    s.session = { widgets = {}, action = {} }

    local function build_button(image, callback)

        local widget = wibox.widget {
                widget = button,
                {
                    widget = wibox.container.margin,
                    margins = dpi(10),
                    {
                        widget  = wibox.widget.imagebox,
                        image   = image,
                        resize  = true,
                        forced_height = dpi(24),
                    }
                }
        }

        widget:connect_signal('button::release', function()
            callback()
        end)

        return widget
    end

    local function confirm_callback()
        spawn(s.session.action.cmd)
        awesome.emit_signal('session::confirm:hide')
    end

    local function cancel_callback()
        awesome.emit_signal('session::confirm:hide')
    end

    local function create_dialog(screen, style)

        style = style or {}
        style.fg            = style.fg or beautiful.fg_normal
        style.bg            = style.bg or beautiful.bg_normal
        style.border_width  = style.border_width or beautiful.border_width
        style.border_color  = style.border_color or beautiful.border_color_active
        style.width         = style.width or dpi(240)
        style.height        = style.height or dpi(200)
        style.icon_size     = style.icon_size or dpi(64)
        style.font          = style.font or beautiful.font_bold

        s.session.widgets.confirm = wibox {
            screen          = screen,
            visible         = false,
            ontop           = true,
            fg              = style.fg,
            bg              = style.bg,
            width           = style.width,
            height          = style.height,
            border_width    = style.border_width,
            border_color    = style.border_color,
        }

        s.session.widgets.confirm:setup {
            {
                {
                    {
                        id              = 'icon',
                        widget          = wibox.widget.imagebox,
                        image           = beautiful.awesome_icon,
                        forced_height   = style.icon_size,
                        resize          = true,
                    },
                    widget = wibox.container.place,
                },
                {
                    {
                        id              = 'message',
                        widget          = wibox.widget.textbox,
                        markup          = '',
                        font            = style.font,
                    },
                    widget = wibox.container.place,
                },
                {
                    {
                        build_button(args.confirm_icon, confirm_callback),
                        build_button(args.cancel_icon, cancel_callback),
                        layout = wibox.layout.flex.horizontal,
                        spacing = dpi(10),
                    },
                    widget = wibox.container.place,
                },
                layout = wibox.layout.fixed.vertical,
                spacing = dpi(20),
            },
            widget = wibox.container.place,
        }

        awful.placement.centered(s.session.widgets.confirm)
    end

    local function create_backdrop(screen, style)

        style = style or {}
        style.backdrop_fg = style.backdrop_fg or beautiful.osd_fg
        style.backdrop_bg = style.backdrop_bg or beautiful.osd_bg

        s.session.widgets.backdrop = wibox {
            screen      = screen,
            type        = 'splash',
            visible     = false,
            ontop       = true,
            fg          = style.backdrop_fg,
            bg          = style.backdrop_bg,
            width       = s.geometry.width,
            height      = s.geometry.height,
            x           = s.geometry.x,
            y           = s.geometry.y,
        }
    end

    create_dialog(s, args)
    if args.backdrop then
        create_backdrop(s, args)
    end

    local keygrabber = awful.keygrabber {
        auto_start = true,
        stop_event = 'release',
        keypressed_callback = function(_, _, key, _)
            if key == 'Return' then
                confirm_callback()
            elseif key == 'Escape' then
                cancel_callback()
            end
        end,
        timeout = args.timeout or 10,
        timeout_callback = function()
            if args.timeout_run then
                confirm_callback()
            else
                cancel_callback()
            end
        end,
    }

    awesome.connect_signal('session::confirm:show', function()
        local icon = s.session.action.icon
        local message = tostring(s.session.action.message)
        s.session.widgets.confirm:get_children_by_id('icon')[1]:set_image(icon)
        s.session.widgets.confirm:get_children_by_id('message')[1]:set_markup(message)

        s.session.widgets.backdrop.visible = true
        s.session.widgets.confirm.visible = false

        awful.screen.focused().session.widgets.backdrop.visible = true
        awful.screen.focused().session.widgets.confirm.visible = true

        keygrabber:start()
    end)

    awesome.connect_signal('session::confirm:hide', function()
        s.session.widgets.backdrop.visible = false
        s.session.widgets.confirm.visible = false

        keygrabber:stop()
    end)
end

return session
