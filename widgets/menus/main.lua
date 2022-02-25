-- Awesome
local awful = require('awful')
local theme = require('beautiful')
local lookup_icon = require('menubar.utils').lookup_icon

-- External
local fd_check, menu = pcall(require, 'freedesktop.menu')

-- Custom
local awesome_menu = require('widgets.menus.awesome')

-- Local
local cfg_apps = _G.cfg.apps or nil

local apps = {}
apps.terminal = cfg_apps.terminal or 'xterm'
apps.files = cfg_apps.files or 'pcmanfm'

local icons = {}
icons.awesome = lookup_icon('preferences-desktop') or theme.awesome_menu_icon
icons.files = lookup_icon('system-file-manager') or theme.menu_files_icon
icons.terminal = lookup_icon('utilities-terminal') or theme.menu_terminal_icon

local _M = function()

    local base = {
        { '&Awesome', awesome_menu, icons.awesome },
        { 'Open &Terminal', apps.terminal, icons.terminal },
        { 'Open &Files', apps.files, icons.files },
    }

    if fd_check then
        return menu.build({
            before = base,
            after = nil,
            sub_menu = nil,
            skip_items = nil,
        })
    else
        return awful.menu({ items = base })
    end
end

return _M
