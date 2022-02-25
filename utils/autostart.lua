local spawn = require('awful.spawn')
local cfg_paths = _G.cfg.paths or nil

local init = function(paths)
    paths = cfg_paths.autostart_dirs or paths or { '$XDG_CONFIG_HOME/autostart/' }

    local path_str = ''
    if #paths then
        for i, p in ipairs(paths) do
            path_str = path_str..p
            if i < #paths then
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

return init
