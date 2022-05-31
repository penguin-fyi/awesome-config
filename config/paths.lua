local paths = {}

--paths.autostart_dirs = { '$XDG_CONFIG_HOME/autostart/' }
paths.autostart_dirs = {
    '/etc/xdg/autostart/',
    '$XDG_CONFIG_HOME/autostart/',
}

--paths.icon_search_dirs = { '/usr/share/icons/gnome/', '/usr/share/pixmaps/' }
paths.icon_search_dirs = {
    '/usr/share/icons/Papirus/',
    '/usr/share/icons/gnome/',
    '/usr/share/pixmaps/',
}

--paths.wallpaper = nil

--paths.rofi_theme_file = os.getenv('XDG_CONFIG_HOME')..'/rofi/themes/awesome.rasi'

--paths.xsd_conf = os.getenv('HOME')..'/.xsettingsd.conf'
paths.xsd_conf = os.getenv('HOME')..'/.config/xsettingsd/xsettingsd.conf'

return paths
