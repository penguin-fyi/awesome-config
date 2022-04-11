local awful = require('awful')
local theme = require('beautiful')

local vars, paths, apps, modkeys = {}, {}, {}, {}

-- Variables
vars.tag_default_layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
}

vars.screen_tags_list = nil
vars.screen_tags_auto = 9

vars.client_focus_sloppy = false
vars.client_focus_raise = false
vars.client_default_icon = theme.awesome_icon

vars.mouse_snap_edge = true
vars.mouse_snap_client = true

vars.titlebar_enable_tooltip = false
vars.titlebar_fallback_name = ''

vars.session_timeout = 10
vars.session_timeout_run = false

vars.topbar_calendar_enabled = false
vars.topbar_calendar_hover = false
vars.topbar_launcher_corner = 'tl'
vars.topbar_prompt_text = 'Run: '
vars.topbar_systray_autohide = false

-- Paths
paths.autostart_dirs = { '$XDG_CONFIG_HOME/autostart/' }
paths.icon_search_dirs = { '/usr/share/icons/gnome/', '/usr/share/pixmaps/' }
paths.wallpaper = nil

-- Apps
apps.terminal = os.getenv('TERMINAL') or 'xterm'
apps.editor = os.getenv('EDITOR') or 'vim'
apps.files = os.getenv('FILEXP') or 'mc'
apps.editor_cmd = apps.terminal..' -e '..apps.editor

apps.awesome_config = apps.editor_cmd..' '..awesome.conffile
apps.awesome_manual = apps.terminal..' -e man awesome'
apps.awesome_restart = 'awesome-client \'awesome.restart()\''
apps.awesome_exit = 'awesome-client \'awesome.quit()\''

-- Modifier keys
modkeys.super = 'Mod4'
modkeys.ctrl = 'Control'
modkeys.shift = 'Shift'
modkeys.alt = 'Mod1'

return {
    vars = vars,
    paths = paths,
    apps = apps,
    modkeys = modkeys,
}
