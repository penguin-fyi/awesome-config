local awful     = require 'awful'
local spawn     = awful.spawn
local theme     = require 'beautiful'
local dpi       = theme.xresources.apply_dpi
local wibox     = require 'wibox'

local button    = require 'widgets.buttons'.gtk

local defaults = {}
defaults.timeout = 10
defaults.timeout_run = false
defaults.enable_backdrop = false

local function session(s, args)
    args = args or {}

    local confirm_icon      = args.confirm_icon or theme.session_confirm_icon
    local cancel_icon       = args.cancel_icon or theme.session_cancel_icon

    local timeout           = args.timeout or defaults.timeout
    local timeout_run       = args.timeout_run or defaults.timeout_run

    s.session = { widgets = {}, action = {} }

    local function build_button(image, callback)

        local widget = wibox.widget {
                {
                    {
                        widget  = wibox.widget.imagebox,
                        image   = image,
                        resize  = true,
                        forced_height = dpi(24),
                    },
                    widget = wibox.container.margin,
                    margins = 10,
                },
                widget = button,
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

        local fg            = style.session_fg or theme.fg_normal
        local bg            = style.session_bg or theme.bg_normal
        local border_width  = style.session_border_width or theme.border_width
        local border_color  = style.session_border_color or theme.border_color_active
        local width         = style.session_width or dpi(240)
        local height        = style.session_height or dpi(200)
        local icon_size     = style.session_icon_size or dpi(64)
        local font          = style.session_font or theme.font_bold

        s.session.widgets.confirm = wibox {
            screen          = screen,
            visible         = false,
            ontop           = true,
            fg              = fg,
            bg              = bg,
            width           = width,
            height          = height,
            border_width    = border_width,
            border_color    = border_color,
        }

        s.session.widgets.confirm:setup {
            {
                {
                    {
                        id              = 'icon',
                        widget          = wibox.widget.imagebox,
                        image           = theme.awesome_icon,
                        forced_height   = icon_size,
                        resize          = true,
                    },
                    widget = wibox.container.place,
                },
                {
                    {
                        id              = 'message',
                        widget          = wibox.widget.textbox,
                        markup          = '',
                        font            = font,
                    },
                    widget = wibox.container.place,
                },
                {
                    {
                        build_button(confirm_icon, confirm_callback),
                        build_button(cancel_icon, cancel_callback),
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

        local fg    = style.session_backdrop_fg or theme.osd_fg
        local bg    = style.session_backdrop_bg or theme.osd_bg

        s.session.widgets.backdrop = wibox {
            screen      = screen,
            type        = 'splash',
            visible     = false,
            ontop       = true,
            fg          = fg,
            bg          = bg,
            width       = s.geometry.width,
            height      = s.geometry.height,
            x           = s.geometry.x,
            y           = s.geometry.y,
        }
    end

    create_dialog(s, args)
    create_backdrop(s, args)

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
        timeout = timeout or 10,
        timeout_callback = function()
            if timeout_run then
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
