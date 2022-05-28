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
vars.client_focus_sloppy = true
--vars.client_focus_raise = false

--vars.session_timeout = 10
--vars.session_timeout_run = false

--vars.topbar_calendar_enabled = false
vars.topbar_calendar_enabled = true
--vars.topbar_calendar_hover = false
--vars.topbar_prompt_text = 'Run: '
--vars.topbar_systray_autohide = false

return vars
