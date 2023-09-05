local ruled = require 'ruled'
local rules = require 'config.rules'

return function (args)
  args = args or {}

  ruled.client.connect_signal('request::rules', function()
    ruled.client.append_rules(rules.client)
  end)
end
