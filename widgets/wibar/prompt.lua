-- Prompt widget
local awful = require 'awful'
local wibox = require 'wibox'

local prompt = function(s, args)

    args = args or {}
    args.prompt_text = args.prompt_text or 'Run > '

    s.prompt = awful.widget.prompt({prompt=args.prompt_text})

    local widget = wibox.widget {
        widget = wibox.container.place,
        s.prompt,
    }

    return widget
end

return prompt
