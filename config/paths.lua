local paths = require('config.defaults').paths

--paths.autostart_dirs = { '$XDG_CONFIG_HOME/autostart/' }
--paths.icon_search_dirs = { '/usr/share/icons/gnome/', '/usr/share/pixmaps/' }
--paths.wallpaper = nil
--paths.rofi_theme_file = os.getenv('XDG_CONFIG_HOME')..'/rofi/themes/awesome.rasi'

paths.autostart_dirs = {
    '/etc/xdg/autostart/',
    '$XDG_CONFIG_HOME/autostart/',
}
paths.icon_search_dirs = {
    '/usr/share/icons/Papirus/',
    '/usr/share/icons/gnome/',
    '/usr/share/pixmaps/',
}
paths.rofi_theme_file = os.getenv('XDG_CONFIG_HOME')..'/rofi/themes/awesome.rasi'

return paths
