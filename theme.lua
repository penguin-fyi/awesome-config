-- Awesome
local gtk           = require('beautiful.gtk')
local assets        = require('beautiful.theme_assets')
local dpi           = require('beautiful.xresources').apply_dpi
local gears         = require('gears')
local gfs           = gears.filesystem
local themes_path   = gfs.get_themes_dir()
local debug         = gears.debug
local shape         = gears.shape

-- Custom
local svg           = require('resources.svgicons')
local render        = svg.render_icon
local color_util    = require('utils.colors')

-- Local
local theme = dofile(themes_path..'default/theme.lua')

-- Misc
theme.useless_gap                   = dpi(4)
theme.opacity                       = 1.0
theme.transparent                   = '#00000000'

-- Load GTK variables
theme.gtk = gtk.get_theme_variables()
if not theme.gtk then
    debug.print_warning("Can't load GTK+3 theme. You're going to have a bad time.")
    return theme
end

-- Map GTK to beautiful
theme.fg_normal                     = theme.gtk.fg_color
theme.bg_normal                     = theme.gtk.bg_color

theme.fg_focus                      = theme.gtk.selected_fg_color
theme.bg_focus                      = theme.gtk.selected_bg_color

theme.fg_urgent                     = theme.gtk.warning_fg_color
theme.bg_urgent                     = theme.gtk.warning_bg_color

theme.fg_minimize                   = theme.gtk.text_color
theme.bg_minimize                   = theme.gtk.base_color

theme.fg_success                    = theme.gtk.success_fg_color
theme.bg_success                    = theme.gtk.success_bg_color

theme.fg_warning                    = theme.gtk.warning_fg_color
theme.bg_warning                    = theme.gtk.warning_bg_color

theme.fg_error                      = theme.gtk.error_fg_color
theme.bg_error                      = theme.gtk.error_bg_color

theme.base_fg                       = theme.gtk.text_color
theme.base_bg                       = theme.gtk.base_color

theme.wibar_fg                      = theme.gtk.menubar_fg_color
theme.wibar_bg                      = theme.gtk.menubar_bg_color

theme.menubar_fg                    = theme.gtk.menubar_fg_color
theme.menubar_bg                    = theme.gtk.menubar_bg_color

-- Icon theme
theme.icon_theme = 'Antsy'

-- Fonts
theme.font                          = theme.gtk.font_family..' '..theme.gtk.font_size
theme.font_bold                     = theme.gtk.font_family..' Bold '..theme.gtk.font_size
theme.font_italic                   = theme.gtk.font_family..' Italic '..theme.gtk.font_size

-- Widgets
local button_shape                  = function(cr, w, h)
                                          shape.rounded_rect(cr, w, h, theme.border_radius)
                                      end

-- Buttons
theme.button_fg                     = theme.gtk.button_fg_color
theme.button_bg                     = theme.gtk.button_bg_color
theme.button_border_color           = theme.gtk.button_border_color
theme.button_border_width           = dpi(theme.gtk.button_border_width or 1)
theme.button_border_radius          = dpi(theme.gtk.button_border_radius or 0)
theme.button_shape                  = button_shape
theme.button_fg_hover               = theme.fg_normal
theme.button_bg_hover               = theme.button_bg
theme.button_border_color_hover     = color_util.mix(theme.bg_focus, theme.base_fg, 0.8)
theme.button_fg_pressed             = theme.fg_focus
theme.button_bg_pressed             = theme.bg_focus
theme.button_border_color_pressed   = color_util.mix(theme.bg_focus, theme.base_fg, 0.8)

-- Header buttons
theme.header_fg                     = theme.gtk.header_button_fg_color
theme.header_bg                     = theme.gtk.header_button_bg_color
theme.header_border_color           = theme.gtk.header_button_border_color
theme.header_fg_hover               = theme.header_fg
theme.header_bg_hover               = theme.header_bg
theme.header_border_color_hover     = color_util.mix(theme.bg_focus, theme.base_fg, 0.8)
theme.header_fg_pressed             = theme.fg_focus
theme.header_bg_pressed             = theme.bg_focus
theme.header_border_color_pressed   = color_util.mix(theme.bg_focus, theme.base_fg, 0.8)

-- OSD (notifications)
theme.osd_fg                        = theme.gtk.osd_fg_color
theme.osd_bg                        = theme.gtk.osd_bg_color
theme.osd_border_color              = theme.gtk.osd_border_color

-- Borders
theme.border_color                  = theme.gtk.wm_bg_color
theme.border_color_normal           = theme.gtk.wm_bg_color
theme.border_color_active           = theme.gtk.wm_border_focused_color
theme.border_color_marked           = theme.gtk.warning_color
theme.border_width                  = dpi(theme.gtk.button_border_width or 0)
theme.border_radius                 = dpi(theme.gtk.button_border_radius or 0)

-- Titlebar
theme.titlebar_fg_normal            = theme.base_fg
theme.titlebar_bg_normal            = theme.menubar_bg
theme.titlebar_font_normal          = theme.font_bold
theme.titlebar_fg_focus             = theme.fg_normal
theme.titlebar_bg_focus             = theme.menubar_bg
theme.titlebar_font_focus           = theme.font_bold
theme.titlebar_fg_urgent            = theme.fg_success
theme.titlebar_bg_urgent            = theme.menubar_bg
theme.titlebar_font_urgent          = theme.font_bold
theme.titlebar_height               = dpi(20)
theme.titlebar_shape                = button_shape

theme.titlebar_ontop_button_focus_active = render(svg.titlebar.ontop_alt, theme.fg_normal)
theme.titlebar_ontop_button_focus_active_hover = render(svg.titlebar.ontop_alt, theme.bg_warning)
theme.titlebar_ontop_button_focus_active_press = render(svg.titlebar.ontop_alt, theme.bg_focus)
theme.titlebar_ontop_button_focus_inactive = render(svg.titlebar.ontop, theme.fg_normal)
theme.titlebar_ontop_button_focus_inactive_hover = render(svg.titlebar.ontop, theme.bg_warning)
theme.titlebar_ontop_button_focus_inactive_press = render(svg.titlebar.ontop, theme.bg_focus)
theme.titlebar_ontop_button_normal_active = render(svg.titlebar.ontop_alt, theme.fg_normal)
theme.titlebar_ontop_button_normal_active_hover = render(svg.titlebar.ontop_alt, theme.bg_warning)
theme.titlebar_ontop_button_normal_active_press = render(svg.titlebar.ontop_alt, theme.bg_focus)
theme.titlebar_ontop_button_normal_inactive = render(svg.titlebar.ontop, theme.fg_normal)
theme.titlebar_ontop_button_normal_inactive_hover = render(svg.titlebar.ontop, theme.bg_warning)
theme.titlebar_ontop_button_normal_inactive_press = render(svg.titlebar.ontop, theme.bg_focus)

theme.titlebar_sticky_button_focus_active = render(svg.titlebar.sticky_alt, theme.fg_normal)
theme.titlebar_sticky_button_focus_active_hover = render(svg.titlebar.sticky_alt, theme.bg_success)
theme.titlebar_sticky_button_focus_active_press = render(svg.titlebar.sticky_alt, theme.bg_focus)
theme.titlebar_sticky_button_focus_inactive = render(svg.titlebar.sticky, theme.fg_normal)
theme.titlebar_sticky_button_focus_inactive_hover = render(svg.titlebar.sticky, theme.bg_success)
theme.titlebar_sticky_button_focus_inactive_press = render(svg.titlebar.sticky, theme.bg_focus)
theme.titlebar_sticky_button_normal_active = render(svg.titlebar.sticky_alt, theme.fg_normal)
theme.titlebar_sticky_button_normal_active_hover = render(svg.titlebar.sticky_alt, theme.bg_success)
theme.titlebar_sticky_button_normal_active_press = render(svg.titlebar.sticky_alt, theme.bg_focus)
theme.titlebar_sticky_button_normal_inactive = render(svg.titlebar.sticky, theme.fg_normal)
theme.titlebar_sticky_button_normal_inactive_hover = render(svg.titlebar.sticky, theme.bg_success)
theme.titlebar_sticky_button_normal_inactive_press = render(svg.titlebar.sticky, theme.bg_focus)

theme.titlebar_minimize_button_normal = render(svg.titlebar.minimize, theme.fg_normal)
theme.titlebar_minimize_button_normal_hover = render(svg.titlebar.minimize, theme.bg_warning)
theme.titlebar_minimize_button_focus = render(svg.titlebar.minimize, theme.fg_normal)
theme.titlebar_minimize_button_focus_hover = render(svg.titlebar.minimize, theme.bg_warning)
theme.titlebar_minimize_button_focus_press = render(svg.titlebar.minimize, theme.bg_focus)

theme.titlebar_maximized_button_focus_active = render(svg.titlebar.maximize_alt, theme.fg_normal)
theme.titlebar_maximized_button_focus_active_hover = render(svg.titlebar.maximize_alt, theme.bg_success)
theme.titlebar_maximized_button_focus_active_press = render(svg.titlebar.maximize_alt, theme.bg_focus)
theme.titlebar_maximized_button_focus_inactive = render(svg.titlebar.maximize, theme.fg_normal)
theme.titlebar_maximized_button_focus_inactive_hover = render(svg.titlebar.maximize, theme.bg_success)
theme.titlebar_maximized_button_focus_inactive_press = render(svg.titlebar.maximize, theme.bg_focus)
theme.titlebar_maximized_button_normal_active = render(svg.titlebar.maximize_alt, theme.fg_normal)
theme.titlebar_maximized_button_normal_active_hover = render(svg.titlebar.maximize_alt, theme.bg_success)
theme.titlebar_maximized_button_normal_active_press = render(svg.titlebar.maximize_alt, theme.bg_focus)
theme.titlebar_maximized_button_normal_inactive = render(svg.titlebar.maximize, theme.fg_normal)
theme.titlebar_maximized_button_normal_inactive_hover = render(svg.titlebar.maximize, theme.bg_success)
theme.titlebar_maximized_button_normal_inactive_press = render(svg.titlebar.maximize, theme.bg_focus)

theme.titlebar_close_button_normal = render(svg.titlebar.close, theme.fg_normal)
theme.titlebar_close_button_normal_hover = render(svg.titlebar.close_alt, theme.bg_error)
theme.titlebar_close_button_focus = render(svg.titlebar.close, theme.bg_error)
theme.titlebar_close_button_focus_hover = render(svg.titlebar.close_alt, theme.bg_error)
theme.titlebar_close_button_focus_press = render(svg.titlebar.close_alt, theme.bg_focus)

-- Launcher widget
theme.menu_button_icon              = render(svg.wibars.main_menu, theme.button_fg, nil, 24)

-- Taglist widget
theme.taglist_fg_empty              = theme.header_border_color
theme.taglist_bg_empty              = theme.transparent
theme.taglist_fg_occupied           = theme.header_fg
theme.taglist_bg_occupied           = theme.transparent
theme.taglist_fg_focus              = theme.button_fg
theme.taglist_bg_focus              = theme.bg_focus
theme.taglist_fg_urgent             = theme.button_fg
theme.taglist_bg_urgent             = theme.bg_success
theme.taglist_bg_container          = theme.transparent
theme.taglist_shape                 = button_shape
theme.taglist_squares_sel           = nil
theme.taglist_squares_unsel         = nil

-- Layout widget
theme.layout_cornerne               = render(svg.layouts.cornerne, theme.button_fg, nil, 24)
theme.layout_cornernw               = render(svg.layouts.cornernw, theme.button_fg, nil, 24)
theme.layout_cornerse               = render(svg.layouts.cornerse, theme.button_fg, nil, 24)
theme.layout_cornersw               = render(svg.layouts.cornersw, theme.button_fg, nil, 24)
theme.layout_dwindle                = render(svg.layouts.dwindle, theme.button_fg, nil, 24)
theme.layout_fairh                  = render(svg.layouts.fairh, theme.button_fg, nil, 24)
theme.layout_fairv                  = render(svg.layouts.fairv, theme.button_fg, nil, 24)
theme.layout_floating               = render(svg.layouts.floating, theme.button_fg, nil, 24)
theme.layout_fullscreen             = render(svg.layouts.fullscreen, theme.button_fg, nil, 24)
theme.layout_magnifier              = render(svg.layouts.magnifier, theme.button_fg, nil, 24)
theme.layout_max                    = render(svg.layouts.max, theme.button_fg, nil, 24)
theme.layout_spiral                 = render(svg.layouts.spiral, theme.button_fg, nil, 24)
theme.layout_tile                   = render(svg.layouts.tile, theme.button_fg, nil, 24)
theme.layout_tilebottom             = render(svg.layouts.tilebottom, theme.button_fg, nil, 24)
theme.layout_tileleft               = render(svg.layouts.tileleft, theme.button_fg, nil, 24)
theme.layout_tiletop                = render(svg.layouts.tiletop, theme.button_fg, nil, 24)

-- Tasklist widget
theme.tasklist_fg_normal            = theme.header_fg
theme.tasklist_bg_normal            = theme.transparent
theme.tasklist_fg_focus             = theme.base_fg
theme.tasklist_bg_focus             = theme.bg_focus
theme.tasklist_fg_urgent            = theme.base_fg
theme.tasklist_bg_urgent            = theme.bg_success
theme.tasklist_fg_minimize          = theme.header_border_color
theme.tasklist_bg_minimize          = theme.transparent
theme.tasklist_sticky               = ' '
theme.tasklist_ontop                = ' '
theme.tasklist_above                = ' '
theme.tasklist_below                = ' '
theme.tasklist_floating             = ' '
theme.tasklist_minimized            = ' '
theme.tasklist_maximized            = ' '
theme.tasklist_maximized_horizontal = ' '
theme.tasklist_maximized_vertical   = ' '

-- Systray widget
theme.bg_systray                    = theme.wibar_bg
theme.systray_icon_spacing          = dpi(2)
theme.systray_visible_icon          = render(svg.wibars.systray_visible, theme.button_fg, nil, 24)
theme.systray_hidden_icon           = render(svg.wibars.systray_hidden, theme.button_fg, nil, 24)

-- Keyboard layout widget
theme.keyboard_layout_icon          = render(svg.wibars.keyboard_layout, theme.button_fg, nil, 24)

-- Clock widget
theme.calendar_style                = {
                                          fg_color      = theme.fg_color,
                                          bg_color      = theme.bg_color,
                                          shape         = button_shape,
                                          padding       = dpi(2),
                                          border_color  = theme.base_bg,
                                          border_width  = theme.border_width,
                                          opacity       = theme.opacity,
                                      }
theme.calendar_normal_fg_color      = theme.button_fg
theme.calendar_normal_bg_color      = theme.button_bg
theme.calendar_normal_border_color  = theme.button_border_color
theme.calendar_focus_fg_color       = theme.fg_focus
theme.calendar_focus_bg_color       = theme.bg_focus
theme.calendar_header_fg_color      = theme.header_fg
theme.calendar_header_bg_color      = theme.header_bg
theme.calendar_header_border_color  = theme.header_border_color
theme.calendar_weekday_fg_color     = theme.border_color_active
theme.calendar_weekday_bg_color     = theme.button_bg
theme.calendar_weekday_border_color = theme.button_bg

-- Session widget
theme.session_button_icon            = render(svg.wibars.session_menu, theme.button_fg, nil, 24)
theme.session_confirm_icon           = render(svg.session.confirm, theme.fg_normal, nil, 24)
theme.session_cancel_icon            = render(svg.session.cancel, theme.fg_normal, nil, 24)

-- Menus
theme.menu_button_width             = dpi(32)
theme.menu_button_text              = nil
theme.menu_fg_normal                = theme.menubar_fg
theme.menu_bg_normal                = theme.menubar_bg
theme.menu_border_width             = theme.button_border_width
theme.menu_border_color             = theme.base_bg
theme.menu_width                    = dpi(160)
theme.menu_height                   = dpi(24)
theme.menu_submenu                  = render(svg.menus.submenu, theme.fg_normal, nil, 24)
theme.menu_submenu_icon             = render(svg.menus.submenu, theme.fg_normal, nil, 24)

-- Hotkeys popup
theme.hotkeys_fg                    = theme.fg_normal
theme.hotkeys_bg                    = theme.bg_normal
theme.hotkeys_label_fg              = theme.fg_focus
theme.hotkeys_label_bg              = theme.button_bg
theme.hotkeys_modifiers_fg          = theme.bg_warning
theme.hotkeys_font                  = theme.font_bold
theme.hotkeys_description_font      = theme.font
theme.hotkeys_border_color          = theme.base_bg
theme.hotkeys_border_width          = theme.border_width
theme.hotkeys_shape                 = button_shape
theme.hotkeys_group_margin          = dpi(2)

-- Notifications
theme.notification_position         = 'top_right'
theme.notification_width            = dpi(240)
theme.notification_height           = dpi(30)
theme.notification_icon_size        = dpi(48)
theme.notification_font             = theme.font
theme.notification_fg               = theme.osd_fg
theme.notification_bg               = theme.osd_bg
theme.notification_border_color     = theme.osd_border_color
theme.notification_border_width     = theme.border_width
theme.notification_shape            = button_shape
theme.notification_opacity          = theme.opacity
theme.notification_padding          = theme.useless_gap
theme.notification_spacing          = theme.useless_gap
theme.notification_default_icon     = assets.awesome_icon(
                                        theme.notification_icon_size,
                                        theme.bg_focus,
                                        theme.fg_focus
                                    )

-- Tooltips
theme.tooltip_fg                    = theme.gtk.tooltip_fg_color
theme.tooltip_bg                    = theme.gtk.tooltip_bg_color
theme.tooltip_border_color          = theme.base_bg
theme.tooltip_border_width          = dpi(1)
theme.tooltip_font                  = theme.font
theme.tooltip_opacity               = theme.opacity
theme.tooltip_gaps                  = dpi(2)
theme.tooltip_shape                 = theme.titlebar_shape
theme.tooltip_align                 = 'left'

-- Window snapping
theme.snapper_gap                   = dpi(3)
theme.snap_bg                       = theme.base_bg
theme.snap_border_width             = theme.border_width
theme.snap_shape                    = button_shape

-- Awesome icon
theme.awesome_icon = assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Wallpaper
theme.wallpaper_fg = theme.bg_normal
theme.wallpaper_bg = color_util.mix(theme.bg_focus, theme.bg_normal, 0.50)
theme.wallpaper_markup = '  +  '

return theme
