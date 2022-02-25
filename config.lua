local awful = require('awful')
local menubar = require('menubar')

-- Define modkeys
local modkey = {}
modkey.super    = 'Mod4'
modkey.ctrl     = 'Control'
modkey.shift    = 'Shift'
modkey.alt      = 'Mod1'

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
vars.client_focus_sloppy = true
vars.client_focus_raise = false
vars.client_opacity_exclude_class = {'vlc', 'mpv', 'valheim.x86_64'}
vars.topbar_calendar_enabled = true

-- User paths
local paths = {}
paths.config_dir            = os.getenv('XDG_CONFIG_HOME')..'/awesome/'
paths.autostart_dirs        = {
                                '/etc/xdg/autostart/',
                                '$XDG_CONFIG_HOME/autostart/',
                              }
paths.icon_search_dirs      = {
                                '/usr/share/icons/Papirus/',
                                '/usr/share/icons/gnome/',
                                '/usr/share/pixmaps/',
                              }

-- User apps
local apps = {}
apps.terminal   = os.getenv('TERMINAL') or 'kitty'
apps.editor     = os.getenv('EDITOR')   or 'vim'
apps.files      = os.getenv('FILEXP')   or 'pcmanfm'

apps.editor_cmd = apps.terminal..' -e '..apps.editor

-- Extra options
require('awful.autofocus')
menubar.utils.terminal = apps.terminal
menubar.show_categories = false
awful.titlebar.enable_tooltip = false
awful.mouse.snap.edge_enabled = true
awful.mouse.snap.client_enabled = true

return {
    modkey = modkey,
    vars = vars,
    paths = paths,
    apps = apps,
}
