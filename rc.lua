-- awesome_mode: api-level=4:screen=on

-- Load modules
local beautiful         = require 'beautiful'

local cfg               = require 'config'
local bindings          = require 'config.bindings'
local bindings_external = require 'config.bindings_external'

local client_focus      = require 'signals.client.focus'
local client_icon       = require 'signals.client.icon'
local client_placement  = require 'signals.client.placement'
local client_titlebars  = require 'signals.client.titlebars'

local naughty_display   = require 'signals.naughty.display'
local naughty_icons     = require 'signals.naughty.icons'

local screen_desktop    = require 'signals.screen.desktop'
local screen_session    = require 'signals.screen.session'
local screen_tags       = require 'signals.screen.tags'
local screen_wallpaper  = require 'signals.screen.wallpaper'
local screen_wibar      = require 'signals.screen.wibar'

local tag_layouts       = require 'signals.tag.layouts'

local xdg_autostart     = require 'utils.autostart'
local error_handling    = require 'utils.error_handling'

-- Startup errors
error_handling()

-- Import XSETTINGS before theme
_G.xsettings            = require 'utils.xsettings'

-- Load theme
local theme             = require 'themes.ngui.theme'
beautiful.init(theme)

-- Connect signals
tag_layouts({
    layout_list         = cfg.vars.tag_default_layouts,
})

screen_tags({
    tags_auto           = cfg.vars.screen_tags_auto,
})
screen_wibar({
    calendar_enabled    = cfg.vars.wibar_calendar_enabled,
})
screen_desktop({
    open_with           = cfg.apps.files,
})
screen_wallpaper()
screen_session()

client_titlebars({
    tooltips            = cfg.vars.titlebar_enable_tooltip,
})
client_placement()
client_focus()
client_icon({
    default_icon        = cfg.vars.client_default_icon,
})

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
    focus_raise         = cfg.vars.client_focus_raise,
})
bindings_external()

-- Load rules
require 'rules'

-- XDG autostart
xdg_autostart({
    dirs                = cfg.paths.autostart_dirs
})
