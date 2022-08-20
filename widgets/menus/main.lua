local beautiful = require 'beautiful'

local fd_menu       = require 'utils.fd_menu'
local find_icon     = require 'utils.icon_finder'.lookup
local click_to_hide = require 'utils.click_to_hide'.menu
local awesome_menu  = require 'widgets.menus.awesome'

local awesome_menu_icon = find_icon(beautiful.awesome_menu_icon)

local base_menu = {
    { '&Awesome', awesome_menu, awesome_menu_icon },
}

local main_menu = fd_menu.build({
    before = nil,
    after = base_menu,
    sub_menu = nil,
    skip_items = nil,
})

click_to_hide(main_menu)

return main_menu
