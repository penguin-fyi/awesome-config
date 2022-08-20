--- XDG autostart
-- https://wiki.archlinux.org/title/awesome#Autostart
local spawn = require 'awful.spawn'

local default_dirs = { '$XDG_CONFIG_HOME/autostart/' }

local function autostart(args)

    args = args or {}
    args.dirs = args.dirs or default_dirs

    -- build search-paths
    local path_str = ''
    if #args.dirs then
        for i, p in ipairs(args.dirs) do
            path_str = path_str..p
            if i < #args.dirs then
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
