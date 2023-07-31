-- awesome_mode: api-level=4:screen=on

-- Load modules
local beautiful         = require 'beautiful'
local menubar           = require 'menubar'

local cfg               = require 'config'
local bindings          = require 'config.bindings'
local bindings_external = require 'config.bindings_external'

local client_focus      = require 'signals.client.focus'
local client_icon       = require 'signals.client.icon'
local client_placement  = require 'signals.client.placement'
local client_titlebars  = require 'signals.client.titlebars'

local naughty_display   = require 'signals.naughty.display'
local naughty_icons     = require 'signals.naughty.icons'

local screen_session    = require 'signals.screen.session'
local screen_tags       = require 'signals.screen.tags'
local screen_wallpaper  = require 'signals.screen.wallpaper'
local screen_wibar      = require 'signals.screen.wibar'

local tag_layouts       = require 'signals.tag.layouts'

local xdg_autostart     = require 'utils.autostart'
local error_handling    = require 'utils.error_handling'
local init_xsettings    = require 'utils.xsettings'

menubar.utils.terminal = cfg.apps.terminal

-- Startup errors
error_handling()

-- Import XSETTINGS before theme
init_xsettings({
    path                = cfg.paths.xsd_conf
})

-- Load theme
local theme             = require 'themes.ngui.theme'
beautiful.init(theme)

-- Connect signals
tag_layouts({
    layout_list         = cfg.vars.tag_default_layouts,
})

screen_tags({
    tags_list           = cfg.vars.screen_tags_list,
    tags_auto           = cfg.vars.screen_tags_auto,
})
screen_wibar({
    taglist_tooltip     = cfg.vars.wibar_taglist_tooltip,
    tasklist_tooltip    = cfg.vars.wibar_tasklist_tooltip,
})
screen_session()
screen_wallpaper()

client_titlebars({
    tooltips            = cfg.vars.titlebar_enable_tooltip,
    fade                = cfg.vars.titlebar_unfocus_fade,
})
client_placement()
client_focus()
client_icon()

naughty_display()
naughty_icons({
    icon_dirs           = cfg.paths.icon_search_dirs,
})

-- Load menus
_G.menus = {
    main                = require 'widgets.menus.main',
    session             = require 'widgets.menus.session',
}

-- Load key and mouse bindings
bindings({
    terminal            = cfg.apps.terminal,
})
bindings_external()

-- Load rules
require 'rules'

-- XDG autostart
xdg_autostart({
    dirs                = cfg.paths.autostart_dirs,
})
