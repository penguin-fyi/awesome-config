local ruled = require 'ruled'
local rules = require 'config.rules'

return function (args)
  args = args or {}

  ruled.notification.connect_signal('request::rules', function()
    ruled.notification.append_rules(rules.notifications)
  end)
end

