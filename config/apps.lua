local apps = {}

apps.terminal   = 'kitty'
apps.editor     = 'xdg-open'
apps.files      = 'pcmanfm'
apps.wallpaper  = 'nitrogen --restore'

apps.config     = 'xdg-open '..awesome.conffile
apps.manual     = 'xterm -e man awesome'
apps.restart    = 'awesome-client \'awesome.restart()\''

apps.lock       = 'light-locker-command -l'
apps.exit       = 'awesome-client \'awesome.quit()\''
apps.reboot     = 'systemctl reboot'
apps.suspend    = 'systemctl suspend'
apps.poweroff   = 'systemctl poweroff'

return apps
