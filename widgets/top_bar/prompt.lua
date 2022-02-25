-- Awesome
local awful = require('awful')

-- Custom
local mod = _G.cfg.modkey
local cfg_vars = _G.cfg.vars or nil

-- Local
local vars = {}
vars.prompt_text = cfg_vars.topbar_prompt_text or 'Run: '

-- Prompt widget
local _M = function(s)
    s = s or screen.focused()
    s.prompt = awful.widget.prompt({prompt=vars.prompt_text})

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
        function ()
            awful.prompt.run {
                prompt       = 'Run Lua code: ',
                textbox      = awful.screen.focused().prompt.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. '/history_eval'
            }
        end,
        {description = 'Eval Lua', group = 'awesome'}),
})

return _M
