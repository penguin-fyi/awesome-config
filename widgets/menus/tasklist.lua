local awful = require 'awful'

local click_to_hide = require 'utils.click_to_hide'.menu
local find_icon = require 'utils.icon_finder'.lookup

local minimize      = find_icon('window-minimize')
local unminimize    = find_icon('window')
local maximize      = find_icon('window-maximize')
local unmaximize    = find_icon('window-new')
local float         = find_icon('osd-duplicate')
local unfloat       = find_icon('view-restore')
local fullscreen    = find_icon('view-fullscreen')
local unfullscreen  = find_icon('view-restore')
local ontop         = find_icon('window-keep-above')
local unontop       = find_icon('window-keep-below')
local sticky        = find_icon('window-pin')
local unsticky      = find_icon('window-unpin')
local close         = find_icon('window-close')

local function tasklist_menu(c, args)
  args = args or {}

  local items = {}

  if c.minimized then
    table.insert(items, { 'UnMi&nimize', function() c:activate() end, unminimize })
  else
    table.insert(items, { 'Mi&nimize', function() c.minimized = true end, minimize })
  end

  if c.maximized then
    table.insert(items, { 'UnMa&ximize', function() c.maximized = false end, unmaximize })
  else
    table.insert(items, { 'Ma&ximize', function() c.maximized = true end, maximize })
  end

  if c.floating then
    table.insert(items, { 'Un&Float', function() c.floating = false end, unfloat })
  else
    table.insert(items, { '&Float', function() c.floating = true end, float })
  end

  if c.fullscreen then
    table.insert(items, { 'Un&Fullscreen', function() c.fullscreen = false end, unfullscreen })
  else
    table.insert(items, { '&Fullscreen', function() c.fullscreen = true end, fullscreen })
  end

  if c.sticky then
    table.insert(items, { 'Un&Sticky', function() c.sticky = false end, unsticky })
  else
    table.insert(items, { '&Sticky', function() c.sticky = true end, sticky })
  end

  if c.ontop then
    table.insert(items, { 'Un&Ontop', function() c.ontop = false end, unontop })
  else
    table.insert(items, { '&Ontop', function() c.ontop = true end, ontop })
  end

  table.insert(items, { '&Close', function() c:kill() end, close })

  local menu = awful.menu(items)

  click_to_hide(menu)

  return menu

end

return tasklist_menu
