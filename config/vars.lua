local awful = require 'awful'

local vars = {}

--vars.tag_default_layouts = {
--    awful.layout.suit.floating,
--    awful.layout.suit.tile,
--    awful.layout.suit.tile.left,
--    awful.layout.suit.tile.bottom,
--    awful.layout.suit.tile.top,
--    awful.layout.suit.fair,
--    awful.layout.suit.fair.horizontal,
--    awful.layout.suit.spiral,
--    awful.layout.suit.spiral.dwindle,
--    awful.layout.suit.max,
--    awful.layout.suit.max.fullscreen,
--    awful.layout.suit.magnifier,
--    awful.layout.suit.corner.nw,
--}
vars.tag_default_layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.tile,
}

--vars.screen_tags_list = nil
--vars.screen_tags_auto = 9
vars.screen_tags_auto = 4

--vars.wibar_clock_format = ' %a %b %d, %H:%M '
--vars.wibar_clock_interval = 30
--vars.wibar_calendar_enabled = false
--vars.wibar_calendar_hover = false
--vars.wibar_calendar_position = 'tr'
--vars.wibar_prompt_text = 'Run: '
--vars.wibar_launcher_position = 'tl'
--vars.wibar_session_icon = nil
--vars.wibar_session_width = 24
--vars.wibar_session_position = 'tr'
--vars.wibar_taglist_tooltips = false
--vars.wibar_tasklist_tooltips = false
vars.wibar_calendar_enabled = true
vars.wibar_taglist_tooltip = true
vars.wibar_tasklist_tooltip = true


--vars.desktop_open_with = 'xdg-open'
--vars.desktop_font = theme.font_bold
--vars.desktop_icons = {}
--vars.desktop_iconsize = 48
--vars.desktop_labelsize = 96
--vars.desktop_margin = { x = 20, y = 20 }
--vars.desktop_padding = 4
--vars.desktop_spacing = 4
--vars.desktop_spawn_opt = nil

--vars.session_timeout = 10
--vars.session_timeout_run = false
--vars.session_confirm_icon = nil
--vars.session_cancel_icon = nil

--vars.titlebar_height = 20
--vars.titlebar_enable_tooltip = false
--vars.titlebar_fallback_name = ''
vars.titlebar_enable_tooltip = true
vars.titlebar_unfocus_fade = 0.25

--vars.client_focus_sloppy = false
--vars.client_focus_raise = true
vars.client_focus_sloppy = true

--vars.client_default_icon = theme.awesome_icon

--vars.mouse_snap_edge = true
--vars.mouse_snap_client = true

return vars
