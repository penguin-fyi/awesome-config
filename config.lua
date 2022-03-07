-- Awesome
local awful = require('awful')

-- Define modkeys
local modkey = {}
modkey.super    = 'Mod4'
modkey.ctrl     = 'Control'
modkey.shift    = 'Shift'
modkey.alt      = 'Mod1'

-- User apps
local apps = {}
apps.terminal   = os.getenv('TERMINAL') or 'xterm'
apps.editor     = os.getenv('EDITOR')   or 'leafpad'
apps.files      = os.getenv('FILEXP')   or 'pcmanfm'

apps.editor_cmd = apps.terminal..' -e '..apps.editor

-- User variables
local vars = {}
vars.tag_default_layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.tile,
}
vars.screen_tags_auto = 4
vars.topbar_calendar_enabled = true

--vars.tag_default_layouts = {}
--vars.screen_tags_list = nil
--vars.screen_tags_auto = 9
--vars.client_focus_sloppy = false
--vars.client_focus_raise = false
--vars.client_default_icon = theme.awesome_icon
--vars.rofi_fg = theme.fg_normal
--vars.rofi_bg = theme.bg_normal
--vars.rofi_focus = theme.bg_focus
--vars.rofi_width = theme.menu_width*2
--vars.rofi_radius = theme.border_radius
--vars.rofi_font = theme.font
--vars.session_timeout = 10
--vars.session_timeout_run = false
--vars.topbar_calendar_enabled = false
--vars.topbar_calendar_hover = false
--vars.topbar_launcher_corner = 'tl'
--vars.topbar_prompt_text = 'Run: '
--vars.topbar_systray_autohide = false

-- User paths
local paths = {}
paths.autostart_dirs        = {
                                '/etc/xdg/autostart/',
                                '$XDG_CONFIG_HOME/autostart/',
                              }
paths.icon_search_dirs      = {
                                '/usr/share/icons/Papirus/',
                                '/usr/share/icons/gnome/',
                                '/usr/share/pixmaps/',
                              }
paths.wallpaper             = nil -- '/usr/share/pixmaps/archlinux-logo-text-dark.svg'

--paths.autostart_dirs        = { '$XDG_CONFIG_HOME/autostart/' }
--paths.icon_search_dirs      = { '/usr/share/icons/gnome/', '/usr/share/pixmaps/' }
--paths.wallpaper             = nil

-- Extra options
require('awful.autofocus')
awful.mouse.snap.edge_enabled = true
awful.mouse.snap.client_enabled = true

return {
    modkey = modkey,
    apps = apps,
    vars = vars,
    paths = paths,
}
