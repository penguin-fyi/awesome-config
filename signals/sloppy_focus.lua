-- Sloppy focus
local join = require('gears.table').join

local default_vars = {
    client_focus_sloppy = false,
    client_focus_raise = false,
}
local user_vars = require('config.vars')
local vars = join(default_vars, user_vars)

client.connect_signal('mouse::enter', function(c)
    if vars.client_focus_sloppy then
        c:activate {
            context = 'mouse_enter',
            raise = vars.client_focus_raise
        }
    end
end)
