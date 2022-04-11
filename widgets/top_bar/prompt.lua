local awful = require('awful')

local mod = require('config.modkeys')
local vars = require('config.vars')

-- Prompt widget
local topbar_prompt = function(s)
    s = s or screen.focused()
    s.prompt = awful.widget.prompt({prompt=vars.topbar_prompt_text})

    return s.prompt
end

-- Setup bindings
awful.keyboard.append_global_keybindings({
    -- Run prompt
    awful.key({ mod.super }, 'r',
        function()
            awful.screen.focused().prompt:run()
        end,
        {description = 'Run Command', group = 'launcher'}),
    -- Lua prompt
    awful.key({ mod.super }, 'x',
        function()
            awful.prompt.run {
                prompt       = 'Run Lua code: ',
                textbox      = awful.screen.focused().prompt.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. '/history_eval'
            }
        end,
        {description = 'Eval Lua', group = 'awesome'}),
})

return topbar_prompt
