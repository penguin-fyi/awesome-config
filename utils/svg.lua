local cairo = require('lgi').cairo
local rsvg = require('lgi').Rsvg

local _M = {}

_M.render_data = function(data, color, replace, size)
    if not data then return end
    color = color or nil
    replace = replace or '#ffffff'
    size = size or 16
    local surface = cairo.ImageSurface(cairo.Format.ARGB32, size, size)
    local context = cairo.Context(surface)
    if color then
        data = string.gsub(data, replace, color)
    end
    rsvg.Handle.new_from_data(data):render_cairo(context)
    return surface
end

_M.render_file = function(file, size)
    if not file then return end
    size = size or 16
    local surface = cairo.ImageSurface(cairo.Format.ARGB32, size, size)
    local context = cairo.Context(surface)
    rsvg.Handle.new_from_file(file):render_cairo(context)
    return surface
end

return _M
