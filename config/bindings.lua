local awful         = require 'awful'
local key           = awful.key
local button        = awful.button
local spawn         = awful.spawn
local hotkeys_popup = require 'awful.hotkeys_popup'
local position = require 'utils.common'.menus.get_position
local tag_edit = require 'utils.tag_editor'

local vars = require 'config.vars'
local apps = require 'config.apps'

local mod_keys = {
  super   = 'Mod4',
  ctrl    = 'Control',
  shift   = 'Shift',
  alt     = 'Mod1',
}
local mod = mod_keys

local global_keys = {
  -- Show hotkeys popup
  key ({ mod.super }, 's',
    function ()
      hotkeys_popup.show_help ()
    end, nil,
    {description='show help', group='awesome'}),

  -- Show main menu
  key ({ mod.super }, 'w',
    function ()
      local menu = require 'widgets.menus.main'
      menu:show {coords = position ('tl')}
    end,
    {description = 'show main menu', group = 'awesome'}),

  -- Restart Awesome
  key ({ mod.super, mod.ctrl }, 'r',
    function ()
      awesome.restart ()
    end,
    {description = 'restart awesome', group = 'awesome'}),

  -- Launch terminal
  key ({ mod.super }, 'Return',
    function ()
      spawn(apps.terminal)
    end,
    {description = 'open terminal', group = 'launcher'}),

  -- Toggle systray
  key ({ mod.super, mod.alt }, 's',
    function ()
      awesome.emit_signal('systray_toggle')
    end,
    {description = 'toggle systray', group = 'awesome'}),

  -- Run prompt
  key ({ mod.super }, 'r',
    function ()
      awful.screen.focused().prompt:run()
    end,
    {description = 'Run Command', group = 'prompt'}),

  -- Lua prompt
  key ({ mod.super }, 'x',
    function ()
      awful.prompt.run {
        prompt       = 'Eval > ',
        textbox      = awful.screen.focused().prompt.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. '/history_eval'
      }
    end,
    {description = 'Eval Lua', group = 'prompt'}),

  ---- Global: Focus clients
  -- Focus client to left
  key ({ mod.super }, 'Left',
    function ()
      awful.client.focus.bydirection ('left')
      if client.focus and vars.focus_raise then
        client.focus:raise ()
      end
    end,
    {description = 'focus client to left', group = 'client'}),

  -- Focus client below
  key ({ mod.super }, 'Down',
    function ()
      awful.client.focus.bydirection ('down')
      if client.focus and vars.focus_raise then
        client.focus:raise ()
      end
    end,
    {description = 'focus client below', group = 'client'}),

  -- Focus client above
  key ({ mod.super }, 'Up',
    function ()
      awful.client.focus.bydirection ('up')
      if client.focus and vars.focus_raise then
        client.focus:raise ()
      end
    end,
    {description = 'focus client above', group = 'client'}),

  -- Focus client to right
  key ({ mod.super }, 'Right',
    function ()
      awful.client.focus.bydirection('right')
      if client.focus and vars.focus_raise then
        client.focus:raise()
      end
    end,
    {description = 'focus client to right', group = 'client'}),

  -- Cycle focus previous
  key ({ mod.super }, 'Tab',
    function ()
      awful.client.focus.byidx(-1)
      if client.focus then
        client.focus:raise()
      end
    end,
    {description = 'focus previous client', group = 'client'}),

  -- Cycle focus next
  key ({ mod.super, mod.shift }, 'Tab',
    function ()
      awful.client.focus.byidx( 1)
      if client.focus then
        client.focus:raise()
      end
    end,
    {description = 'focus next client', group = 'client'}),

  -- Focus (random) minimized client
  key ({ mod.super, mod.shift }, 'n',
    function ()
      local c = awful.client.restore()
      if c then
        c:activate { raise = true, context = 'key.unminimize' }
      end
    end,
    {description = 'restore minimized', group = 'client'}),

  -- Focus urgent client
  key ({ mod.super, mod.shift }, 'u',
    function ()
      awful.client.urgent.jumpto()
    end,
    {description = 'jump to urgent client', group = 'client'}),

  ---- Global: Swap clients
  -- Swap with client to left
  key ({ mod.super, mod.shift }, 'Left',
    function ()
      awful.client.swap.bydirection('left')
    end,
    {description = 'swap with client to left', group = 'client'}),

  -- Swap with client below
  key ({ mod.super, mod.shift }, 'Down',
      function ()
          awful.client.swap.bydirection('down')
      end,
      {description = 'swap with client below', group = 'client'}),

  -- Swap with client right
  key ({ mod.super, mod.shift }, 'Up',
      function ()
          awful.client.swap.bydirection('up')
      end,
      {description = 'swap with client above', group = 'client'}),

  -- Swap with client to right
  key ({ mod.super, mod.shift }, 'Right',
      function ()
          awful.client.swap.bydirection('right')
      end,
      {description = 'swap with client to right', group = 'client'}),

  ---- Global: Focus screen
  -- Focus screen to left
  key ({ mod.super, mod.ctrl }, 'Left',
      function ()
          awful.screen.focus_bydirection('left')
      end,
      {description = 'focus screen to left', group = 'screen'}),

  -- Focus screen below
  key ({ mod.super, mod.ctrl }, 'Down',
      function ()
          awful.screen.focus_bydirection('down')
      end,
      {description = 'focus screen below', group = 'screen'}),

  -- Focus screen above
  key ({ mod.super, mod.ctrl }, 'Up',
      function ()
          awful.screen.focus_bydirection('up')
      end,
      {description = 'focus screen above', group = 'screen'}),

  -- Focus screen to right
  key ({ mod.super, mod.ctrl }, 'Right',
      function ()
          awful.screen.focus_bydirection('right')
      end,
      {description = 'focus screen to right', group = 'screen'}),

  ---- Global: Tags
  -- View last tag
  key ({ mod.super }, '`',
    function ()
      awful.tag.history.restore()
    end,
    {description = 'go back', group = 'tag'}),

  -- Go to tag by index
  key {
      modifiers   = { mod.super },
      keygroup    = 'numrow',
      description = 'view tag',
      group       = 'tag',
      on_press    = function (index)
          local screen = awful.screen.focused()
          local tag = screen.tags[index]
          if not tag then
              return
          elseif tag.selected then
              awful.tag.history.restore(screen, 1)
          else
              tag:view_only()
          end
      end
  },

  -- Toggle tag by index
  key {
      modifiers   = { mod.super, mod.ctrl },
      keygroup    = 'numrow',
      description = 'toggle tag',
      group       = 'tag',
      on_press    = function (index)
          local screen = awful.screen.focused()
          local tag = screen.tags[index]
          if tag then
              awful.tag.viewtoggle(tag)
          end
      end,
  },

  -- Move client to tag by index
  key {
      modifiers = { mod.super, mod.shift },
      keygroup    = 'numrow',
      description = 'move focused client to tag',
      group       = 'tag',
      on_press    = function (index)
          if client.focus then
              local tag = client.focus.screen.tags[index]
              if tag then
                  client.focus:move_to_tag(tag)
              end
          end
      end,
  },

  -- Toggle focused client on tag by index
  key {
      modifiers   = { mod.super, mod.ctrl, mod.shift },
      keygroup    = 'numrow',
      description = 'toggle focused client on tag',
      group       = 'tag',
      on_press    = function (index)
          if client.focus then
              local tag = client.focus.screen.tags[index]
              if tag then
                  client.focus:toggle_tag(tag)
              end
          end
      end,
  },

  -- Add new tag (utils.tag_editor)
  key ({ mod.super, mod.ctrl  }, 'a',
      function ()
          tag_edit.add()
      end,
      {description = 'add tag', group = 'tag'}),

  -- Edit current tag (utils.tag_editor)
  key ({ mod.super, mod.ctrl  }, 'e',
      function ()
          tag_edit.rename()
      end,
      {description = 'edit tag', group = 'tag'}),

  -- Move tag left (utils.tag_editor)
  key ({ mod.super, mod.ctrl }, '[',
      function ()
          tag_edit.move('left')
      end,
      {description = 'move tag left', group = 'tag'}),

  -- Move tag right (utils.tag_editor)
  key ({ mod.super, mod.ctrl }, ']',
      function ()
          tag_edit.move('right')
      end,
      {description = 'move tag right', group = 'tag'}),

  -- Delete current tag (utils.tag_editor)
  key ({ mod.super, mod.ctrl  }, 'd',
      function ()
          tag_edit.delete()
      end,
      {description = 'delete tag', group = 'tag'}),

  --- Global: Layouts
  -- Next layout
  key ({ mod.super }, ']',
      function ()
          awful.layout.inc( 1)
      end,
      {description = 'next layout', group = 'layout'}),

  -- Previous layout
  key ({ mod.super }, '[',
      function ()
          awful.layout.inc(-1)
      end,
      {description = 'previous layout', group = 'layout'}),

  --- Global: session
  -- Show session menu
  key ({ mod.super, mod.ctrl }, 'q',
      function ()
          local menu = require 'widgets.menus.session'
          menu:show({coords=position('tr')})
      end,
      {description = 'show session menu', group = 'awesome'}),
}

-- Global: Mouse bindings
local global_buttons = {
  button({ }, 1, function () return end),
}

local client_keys = {
  --- Client
  -- Toggle fullscreen
  key ({ mod.super, mod.shift }, 'f',
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = 'toggle fullscreen', group = 'client'}
  ),
  -- Toggle floating
  key ({ mod.super, mod.ctrl }, 'f',
    function ()
      awful.client.floating.toggle()
    end,
    {description = 'toggle floating', group = 'client'}
  ),
  -- Toggle ontop
  key ({ mod.super, mod.ctrl }, 't',
    function (c)
      c.ontop = not c.ontop
    end,
    {description = 'toggle keep on top', group = 'client'}
  ),
  -- Toggle sticky
  key ({ mod.super, mod.ctrl }, 's',
    function (c)
      c.sticky = not c.sticky
    end,
    {description = 'toggle sticky', group = 'client'}
  ),
  -- Minimize client
  key ({ mod.super, }, 'n',
    function (c)
      c.minimized = true
    end,
    {description = 'minimize', group = 'client'}
  ),
  -- Toggle maximize
  key ({ mod.super, }, 'm',
    function (c)
      c.maximized = not c.maximized
      c:raise()
    end ,
    {description = '(un)maximize', group = 'client'}
  ),
  -- Toggle vertical maximize
  key ({ mod.super, mod.ctrl }, 'm',
    function (c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end ,
    {description = '(un)maximize vertically', group = 'client'}
  ),
  -- Toggle horizontal maximize
  key ({ mod.super, mod.shift }, 'm',
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end ,
    {description = '(un)maximize horizontally', group = 'client'}
  ),
  -- Swap with primary client
  key ({ mod.super, mod.shift }, 'p',
    function (c)
      c:swap(awful.client.getmaster())
    end,
    {description = 'swap with primary', group = 'client'}
  ),
  -- Move client to next screen
  key ({ mod.super, mod.shift }, 'z',
    function (c)
      c:move_to_screen()
    end,
    {description = 'move to screen', group = 'client'}
  ),
  -- Kill client (close)
  key ({ mod.super, mod.ctrl }, 'Escape',
    function (c)
      c:kill()
    end,
    {description = 'close', group = 'client'}
  ),
}

    --- Client: Mouse bindings
local client_buttons = {
  button ({ }, 1,
    function (c)
      c:activate { context = 'mouse_click' }
    end),
}

local extra_keys = {
  key({ mod.super            }, 'space', function() spawn('rofi -show drun') end,
            {description = 'application search', group = 'external'}),
  key({ mod.super, mod.alt   }, 'r', function() spawn('rofi -show run') end,
            {description = 'command search', group = 'external'}),
  key({ mod.super, mod.alt   }, 'Tab', function() spawn('rofi -show window') end,
            {description = 'window search', group = 'external'}),
  key({ mod.super, mod.alt   }, 'p', function() spawn('rofi-pass') end,
            {description = 'password search', group = 'external'}),

  key({ }, 'XF86AudioRaiseVolume', function() spawn('pactl set-sink-volume @DEFAULT_SINK@ +5%', false) end,
            {description = 'raise volume', group = 'external'}),
  key({ }, 'XF86AudioLowerVolume', function() spawn('pactl set-sink-volume @DEFAULT_SINK@ -5%', false) end,
            {description = 'lower volume', group = 'external'}),
  key({ }, 'XF86AudioMute', function() spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle', false) end,
            {description = 'toggle mute', group = 'external'}),

  key({ }, 'XF86AudioPlay', function() spawn('playerctl play-pause', false) end,
            {description = 'toggle play and pause', group = 'external'}),
  key({ }, 'XF86AudioNext', function() spawn('playerctl next', false) end,
            {description = 'go to next track', group = 'external'}),
  key({ }, 'XF86AudioPrev', function() spawn('playerctl previous', false) end,
            {description = 'go to previous track', group = 'external'}),
  key({ }, 'XF86AudioStop', function() spawn('playerctl stop', false) end,
            {description = 'stop playback', group = 'external'}),

  key({ }, 'XF86MonBrightnessUp', function() spawn('xbacklight -inc 10%', false) end,
            {description = 'increase backlight brightness', group = 'external'}),
  key({ }, 'XF86MonBrightnessDown', function() spawn('xbacklight -dec 10%', false) end,
            {description = 'decrease backlight brightness', group = 'external'}),
}

return {
  mod_keys        = mod_keys,
  global_keys     = global_keys,
  global_buttons  = global_buttons,
  client_keys     = client_keys,
  client_buttons  = client_buttons,
  extra_keys      = extra_keys,
}
