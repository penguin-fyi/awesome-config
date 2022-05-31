local awful = require('awful')

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

--vars.client_focus_sloppy = false
--vars.client_focus_raise = true

--vars.titlebar_height = 20
--vars.titlebar_enable_tooltip = false
--vars.titlebar_fallback_name = ''

--vars.session_timeout = 10
--vars.session_timeout_run = false

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
vars.wibar_calendar_enabled = true

--vars.mouse_snap_edge = true
--vars.mouse_snap_client = true

return vars
