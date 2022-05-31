-- Prompt widget
local awful = require 'awful'
local wibox = require 'wibox'

local defaults = {}
defaults.text = 'Run > '

local prompt = function(s, args)
    args = args or {}
    local text = args.prompt_text or defaults.text

    s.prompt = awful.widget.prompt({prompt=text})

    local widget = wibox.widget {
        s.prompt,
        widget = wibox.container.place,
    }

    return widget
end

return prompt
