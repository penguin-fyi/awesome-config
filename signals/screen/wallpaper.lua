-- Call external wallpaper setter
local awful = require 'awful'
local cfg   = require 'config'

local function screen_wallpaper()
    screen.connect_signal('request::wallpaper', function()
        awful.spawn(cfg.apps.wallpaper, false)
    end)
end

return screen_wallpaper
