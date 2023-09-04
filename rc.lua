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
  path                = cfg.paths.xsd_conf
})

-- Load theme
local theme             = require 'themes.ngui.theme'
beautiful.init(theme)

-- Connect signals
require 'signals.tag.layouts'({
  layout_list         = cfg.vars.tag_default_layouts,
})

require 'signals.screen.tags'({
  tags_list           = cfg.vars.screen_tags_list,
  tags_auto           = cfg.vars.screen_tags_auto,
})
require 'signals.screen.wibar'({
  taglist_tooltip     = cfg.vars.wibar_taglist_tooltip,
  tasklist_tooltip    = cfg.vars.wibar_tasklist_tooltip,
})
require 'signals.screen.session'()
require 'signals.screen.wallpaper'()

require 'signals.client.titlebars' ({
    tooltips            = cfg.vars.titlebar_enable_tooltip,
    fade                = cfg.vars.titlebar_unfocus_fade,
})
require 'signals.client.placement'()
require 'signals.client.focus'()
require 'signals.client.icon'()
require 'signals.client.bindings'()


require 'signals.naughty.display'()
require 'signals.naughty.icons'({
    icon_dirs           = cfg.paths.icon_search_dirs,
})

-- Global bindings
keyboard.append_global_keybindings(cfg.bindings.global_keys)
keyboard.append_global_keybindings(cfg.bindings.extra_keys)
mouse.append_global_mousebindings(cfg.bindings.global_buttons)

-- Load rules
require 'rules'

-- XDG autostart
require 'utils.autostart'({
  dirs                = cfg.paths.autostart_dirs,
})
