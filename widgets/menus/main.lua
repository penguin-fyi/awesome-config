local awful = require('awful')
local theme = require('beautiful')
local lookup_icon = require('menubar.utils').lookup_icon

local fd_check, menu = pcall(require, 'freedesktop.menu')

local awesome_menu = require('widgets.menus.awesome')
local click_to_hide = require('utils.click_to_hide').menu

local apps = require('config.apps')

theme.awesome_menu_icon     = lookup_icon(theme.awesome_menu_icon)
theme.menu_files_icon       = lookup_icon(theme.menu_files_icon)
theme.menu_terminal_icon    = lookup_icon(theme.menu_terminal_icon)

local base_menu = {
    { '&Awesome', awesome_menu, theme.awesome_menu_icon },
    { 'Open &Terminal', apps.terminal, theme.menu_terminal_icon },
    { 'Open &Files', apps.files, theme.menu_files_icon },
}

local main_menu = awful.menu({ items = base_menu })

if fd_check then
    main_menu = menu.build({
        before = base_menu,
        after = nil,
        sub_menu = nil,
        skip_items = nil,
    })
end

click_to_hide(main_menu)

return main_menu
