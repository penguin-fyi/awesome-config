local awful         = require 'awful'
local keyboard      = awful.keyboard
local mouse         = awful.mouse

local bindings = require 'config.bindings'

return function (args)
  args = args or {}

  client.connect_signal('request::default_keybindings', function ()
    keyboard.append_client_keybindings(bindings.client_keys)
  end)

  client.connect_signal('request::default_mousebindings', function ()
    mouse.append_client_mousebindings(bindings.client_buttons)
  end)
end
