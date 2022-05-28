local awful = require('awful')
local join = require('gears.table').join

local default_modkeys = {
    super = 'Mod4',
}
local user_mod = require('config.modkeys')
local mod = join(default_modkeys, user_mod)

local default_vars = {
    topbar_prompt_text = 'Run > '
}
local user_vars = require('config.vars')
local vars = join(default_vars, user_vars)

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
                prompt       = 'Eval > ',
                textbox      = awful.screen.focused().prompt.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. '/history_eval'
            }
        end,
        {description = 'Eval Lua', group = 'awesome'}),
})

return topbar_prompt
