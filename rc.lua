-- awesome_mode: api-level=4:screen=on

-- Load Xsettings
_G.xsettings = require 'utils.xsettings'

-- Startup errors
require('utils.error_handling')

-- Load theme
require('beautiful').init(require('theme'))

-- Load menus
_G.menus = {
    main = require('widgets.menus.main'),
    session = require('widgets.menus.session'),
}

-- Connect signals and rules
require('signals')
require('rules')

-- Load key and mouse bindings
require('config.bindings')
require('config.bindings_external')

-- XDG autostart
require('utils.autostart')()

