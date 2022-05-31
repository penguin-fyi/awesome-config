--- XDG autostart
-- https://wiki.archlinux.org/title/awesome#Autostart
local spawn = require('awful.spawn')

local defaults = {}
defaults.dirs = { '$XDG_CONFIG_HOME/autostart/' }

local function autostart(args)
    args = args or {}
    local dirs = args.dirs or defaults.dirs

    -- build search-paths
    local path_str = ''
    if #dirs then
        for i, p in ipairs(dirs) do
            path_str = path_str..p
            if i < #dirs then
                path_str = path_str..':'
            end
        end
    end

    local cmd = {
        exe = 'dex',
        run = 'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;'..
              'xrdb -merge <<< "awesome.started:true";'..
              'dex --environment AwesomeWM --autostart --search-paths "'..path_str..'"',
    }

    spawn.easy_async_with_shell('command -v '..cmd.exe, function(path)
        if not path then return end
        spawn.with_shell(cmd.run)
    end)
end

return autostart
