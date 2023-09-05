-- awesome_mode: api-level=4:screen=on

-- Load modules
local awful             = require 'awful'
local keyboard          = awful.keyboard
local mouse             = awful.mouse
local beautiful         = require 'beautiful'

local cfg               = require 'config'

-- Startup errors
require 'utils.error_handling'()

-- Import XSETTINGS before theme
require 'utils.xsettings'({
  path = os.getenv('HOME')..'/.config/xsettingsd/xsettingsd.conf'
})

-- Load theme
local theme = require 'themes.ngui.theme'
beautiful.init(theme)

-- Connect signals
require 'signals.tag.layouts'({
  layout_list = {
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.tile,
  }
})

require 'signals.ruled.client'()
require 'signals.ruled.notifications'()

require 'signals.screen.tags'({
  tags_auto = 4,
})
require 'signals.screen.wibar'({
  calendar_enabled = true,
  taglist_tooltip = true,
  tasklist_tooltip = true,
})
require 'signals.screen.session'()
require 'signals.screen.wallpaper'()

require 'signals.client.titlebars' ({
  tooltips = true,
  fade = 0.25,
})
require 'signals.client.placement'()
require 'signals.client.focus'({
  sloppy = true,
})
require 'signals.client.icon'()
require 'signals.client.bindings'()

require 'signals.naughty.display'()
require 'signals.naughty.icons'({
  icon_dirs = {
    '/usr/share/icons/Papirus/',
    '/usr/share/icons/gnome/',
    '/usr/share/pixmaps/',
  }
})

-- Global bindings
keyboard.append_global_keybindings(cfg.bindings.global_keys)
keyboard.append_global_keybindings(cfg.bindings.extra_keys)
mouse.append_global_mousebindings(cfg.bindings.global_buttons)

-- Load rules
--require 'rules'

-- XDG autostart
require 'utils.autostart'({
  dirs = {
    '/etc/xdg/autostart/',
    '$XDG_CONFIG_HOME/autostart/',
  }
})
