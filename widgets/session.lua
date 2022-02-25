local awful = require('awful')
local spawn = awful.spawn
local theme = require('beautiful')
local dpi = theme.xresources.apply_dpi
local wibox = require('wibox')

local button = require('widgets.buttons').gtk
local menu_util = require('utils.menus')

local mod = _G.cfg.modkey

local cfg_vars = _G.cfg.vars

local vars = {}
vars.timeout = cfg_vars.session_timeout or 10
vars.timeout_run = cfg_vars.session_timeout_run or false

_G.session = {
    cmd     = nil,
    text    = nil,
    icon    = nil,
}

local _M = function(s)
    local clock = wibox.widget {
        widget  = wibox.widget.textclock,
        font    = theme.font_bold,
        align   = 'center',
        valign  = 'center',
    }

    local icon = wibox.widget {
        widget          = wibox.widget.imagebox,
        image           = theme.awesome_icon,
        resize          = true,
        forced_height   = dpi(128),
    }

    local message = wibox.widget {
        widget          = wibox.widget.textbox,
        markup          = '',
        font            = theme.font_bold,
        align           = 'center',
        valign          = 'center',
    }

    local build_button = function(image, callback)

        local widget = wibox.widget {
            {
                {
                    {
                        widget  = wibox.widget.imagebox,
                        image   = image,
                    },
                    widget      = wibox.container.margin,
                    margins     = dpi(16),
                },
                widget          = button,
                shape           = theme.button_shape,
                border_color    = theme.base_bg,
                border_width    = dpi(1),
                forced_width    = dpi(64),
                forced_height   = dpi(64),
            },
            widget  = wibox.container.margin,
            left    = dpi(16),
            right   = dpi(16),
        }

        local container = wibox.widget {
            widget,
            nil,
            layout      = wibox.layout.fixed.vertical,
        }

        container:connect_signal('button::release', function()
            callback()
        end)

        return container
    end

    local footer = wibox.widget {
        widget  = wibox.widget.textbox,
        markup  = 'Press <b>Enter to Continue</b> or <b>Escape to Cancel</b>',
        font    = theme.font,
        align   = 'center',
        valign  = 'center',
    }

    local on_confirm = function()
        spawn(_G.session.cmd)
        awesome.emit_signal('session::confirm:hide')
    end

    local on_cancel = function()
        awesome.emit_signal('session::confirm:hide')
    end

    local confirm_button = build_button(theme.session_confirm_icon, on_confirm)
    local cancel_button = build_button(theme.session_cancel_icon, on_cancel)

    local create_dialog = function(screen)

        s.session_confirm = wibox {
            screen      = screen,
            type        = 'splash',
            visible     = false,
            ontop       = true,
            fg          = theme.osd_fg,
            bg          = theme.osd_bg,
            height      = s.geometry.height,
            width       = s.geometry.width,
            x           = s.geometry.x,
            y           = s.geometry.y,
        }

        s.session_confirm:setup {
            {
                layout = wibox.layout.align.horizontal,
                expand = 'none',
                nil,
                {
                    widget = wibox.container.margin,
                    top = dpi(10),
                    clock,
                },
                nil,
            },
            {
                layout = wibox.layout.align.vertical,
                {
                    nil,
                    {
                        nil,
                        icon,
                        nil,
                        layout = wibox.layout.align.horizontal,
                        expand = 'none',
                    },
                    nil,
                    layout = wibox.layout.align.vertical,
                    expand = 'none',
                },
                {
                    nil,
                    {
                        message,
                        widget      = wibox.container.margin,
                        margins     = dpi(24),
                    },
                    nil,
                    layout  = wibox.layout.align.horizontal,
                    expand  = 'none',
                },
                {
                    nil,
                    {
                        {
                            confirm_button,
                            cancel_button,
                            layout  = wibox.layout.fixed.horizontal,
                        },
                        widget  = wibox.container.margin,
                        margins = dpi(24),
                    },
                    nil,
                    layout  = wibox.layout.align.horizontal,
                    expand  = 'none',
                }
            },
            {
                nil,
                {
                    footer,
                    widget  = wibox.container.margin,
                    bottom  = dpi(10),
                },
                nil,
                layout  = wibox.layout.align.horizontal,
                expand  = 'none',
            },
            layout  = wibox.layout.align.vertical,
            expand  = 'none',
        }
    end

    local create_backdrop = function(screen)
        s.session_backdrop = wibox {
            screen      = screen,
            type        = 'splash',
            visible     = false,
            ontop       = true,
            fg          = theme.osd_fg,
            bg          = theme.osd_bg,
            height      = s.geometry.height,
            width       = s.geometry.width,
            x           = s.geometry.x,
            y           = s.geometry.y,
        }
    end

    create_dialog(s)
    create_backdrop(s)

    local screen_grabber = awful.keygrabber {
        auto_start = true,
        stop_event = 'release',
        keypressed_callback = function(_, _, key, _)
            if key == 'Return' then
                on_confirm()
            elseif key == 'Escape' then
                on_cancel()
            end
        end,
        timeout = vars.timeout or 10,
        timeout_callback = function()
            if vars.timeout_run then
                on_confirm()
            else
                on_cancel()
            end
        end,
    }

    awesome.connect_signal('session::confirm:show', function()
        message:set_text(_G.session.text)
        icon:set_image(_G.session.icon)

        s.session_backdrop.visible = true
        s.session_confirm.visible = false

        awful.screen.focused().session_confirm.visible = true
        awful.screen.focused().session_backdrop.visible = false

        screen_grabber:start()
    end)

    awesome.connect_signal('session::confirm:hide', function()
        s.session_backdrop.visible = false
        s.session_confirm.visible = false

        screen_grabber:stop()

        _G.session = {}
    end)

    awful.keyboard.append_global_keybindings({
        awful.key({ mod.super, mod.ctrl }, 'q',
            function()
                local pos = menu_util.set_corner('tr')
                _G.menus.session:show({coords=pos})
            end,
            {description = 'show session menu', group = 'awesome'}
        ),
    })

end

return _M
