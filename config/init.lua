local paths         = require('config.paths')
local vars          = require('config.vars')
local apps          = require('config.apps')
local modkeys       = require('config.modkeys')

local bindings          = require 'config.bindings'
local bindings_external = require 'config.bindings_external'

return {
    paths       = paths,
    vars        = vars,
    apps        = apps,
    modkeys     = modkeys,
    bindings    = bindings,
    bindings_external = bindings_external,
}
