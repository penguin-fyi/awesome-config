local awful = require('awful')
local lookup_icon = require('menubar.utils').lookup_icon

local vars = require('config.defaults').vars

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

--vars.screen_tags_list = nil
--vars.screen_tags_auto = 9

--vars.client_focus_sloppy = false
--vars.client_focus_raise = false
--vars.client_default_icon = theme.awesome_icon

--vars.session_timeout = 10
--vars.session_timeout_run = false

--vars.topbar_calendar_enabled = false
--vars.topbar_calendar_hover = false
--vars.topbar_launcher_corner = 'tl'
--vars.topbar_prompt_text = 'Run: '
--vars.topbar_systray_autohide = false

vars.tag_default_layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.tile,
}
vars.screen_tags_auto = 4
vars.topbar_calendar_enabled = true
vars.client_focus_sloppy = true
vars.client_default_icon = lookup_icon('preferences-activities')

return vars
