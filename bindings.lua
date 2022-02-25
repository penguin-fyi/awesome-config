local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
require('awful.hotkeys_popup.keys')

local menu_util = require('utils.menus')
local tag_util = require('utils.tags')

local mod = _G.cfg.modkey or nil
local cfg_vars = _G.cfg.vars or nil
local cfg_apps = _G.cfg.apps or nil

local vars = {}
vars.client_focus_raise = cfg_vars.client_focus_raise or false

local apps = {}
apps.terminal = cfg_apps.terminal or 'xterm'

-- Global: core
awful.keyboard.append_global_keybindings({
    -- Show hotkeys popup
    awful.key({ mod.super }, 's', function() hotkeys_popup.show_help() end,
        {description='show help', group='awesome'}),
    -- Show main menu
    awful.key({ mod.super }, 'w',
        function ()
            local pos = menu_util.set_corner('tl')
            _G.menus.main:show({coords=pos})
        end,
        {description = 'show main menu', group = 'awesome'}
    ),
    -- Restart Awesome
    awful.key({ mod.super, mod.ctrl }, 'r', awesome.restart,
              {description = 'reload awesome', group = 'awesome'}),
    -- Launch terminal
    awful.key({ mod.super }, 'Return', function () awful.spawn(apps.terminal) end,
              {description = 'open a terminal', group = 'launcher'}),
})

-- Global: Focus clients
awful.keyboard.append_global_keybindings({
    -- Focus client to left
    awful.key({ mod.super }, 'Left',
        function()
            awful.client.focus.bydirection('left')
            if client.focus and vars.client_focus_raise then
                client.focus:raise()
            end
        end,
        {description = 'focus client to left', group = 'client'}
    ),
    -- Focus client below
    awful.key({ mod.super }, 'Down',
        function()
            awful.client.focus.bydirection('down')
            if client.focus and vars.client_focus_raise then
                client.focus:raise()
            end
        end,
        {description = 'focus client below', group = 'client'}
    ),
    -- Focus client above
    awful.key({ mod.super }, 'Up',
        function()
            awful.client.focus.bydirection('up')
            if client.focus and vars.client_focus_raise then
                client.focus:raise()
            end
        end,
        {description = 'focus client above', group = 'client'}
    ),
    -- Focus client to right
    awful.key({ mod.super }, 'Right',
        function()
            awful.client.focus.bydirection('right')
            if client.focus and vars.client_focus_raise then
                client.focus:raise()
            end
        end,
        {description = 'focus client to right', group = 'client'}
    ),
    -- Cycle focus previous
    awful.key({ mod.super }, 'Tab',
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = 'focus previous client', group = 'client'}
    ),
    -- Cycle focus next
    awful.key({ mod.super, mod.shift }, 'Tab',
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = 'focus next client', group = 'client'}
    ),
    -- Focus (random) minimized client
    awful.key({ mod.super, mod.shift }, 'n',
        function ()
            local c = awful.client.restore()
            if c then
                c:activate { raise = true, context = 'key.unminimize' }
            end
        end,
        {description = 'restore minimized', group = 'client'}
    ),
    -- Focus urgent client
    awful.key({ mod.super, mod.shift }, 'u', awful.client.urgent.jumpto,
              {description = 'jump to urgent client', group = 'client'}),
})

-- Global: Swap clients
awful.keyboard.append_global_keybindings({
    -- Swap with client to left
    awful.key({ mod.super, mod.shift   }, 'Left', function() awful.client.swap.bydirection('left') end,
        {description = 'swap with client to left', group = 'client'}),
    -- Swap with client below
    awful.key({ mod.super, mod.shift   }, 'Down', function() awful.client.swap.bydirection('down') end,
              {description = 'swap with client below', group = 'client'}),
    -- Swap with client right
    awful.key({ mod.super, mod.shift   }, 'Up', function() awful.client.swap.bydirection('up') end,
              {description = 'swap with client above', group = 'client'}),
    -- Swap with client to right
    awful.key({ mod.super, mod.shift   }, 'Right', function() awful.client.swap.bydirection('right') end,
              {description = 'swap with client to right', group = 'client'}),
})

-- Global: Focus screen
awful.keyboard.append_global_keybindings({
    -- Focus screen to left
    awful.key({ mod.super, mod.ctrl }, 'Left', function() awful.screen.focus_bydirection('left') end,
              {description = 'focus screen to left', group = 'screen'}),
    -- Focus screen below
    awful.key({ mod.super, mod.ctrl }, 'Down', function() awful.screen.focus_bydirection('down') end,
              {description = 'focus screen below', group = 'screen'}),
    -- Focus screen above
    awful.key({ mod.super, mod.ctrl }, 'Up', function() awful.screen.focus_bydirection('up') end,
              {description = 'focus screen above', group = 'screen'}),
    -- Focus screen to right
    awful.key({ mod.super, mod.ctrl }, 'Right', function() awful.screen.focus_bydirection('right') end,
              {description = 'focus screen to right', group = 'screen'}),
})

-- Global: Tags
awful.keyboard.append_global_keybindings({
    -- View last tag
    awful.key({ mod.super }, '`', awful.tag.history.restore,
              {description = 'go back', group = 'tag'}),
    -- Go to tag by index
    awful.key {
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
        end,
    },
    -- Toggle tag by index
    awful.key {
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
    awful.key {
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
    awful.key {
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
    -- Add new tag
    awful.key({ mod.super, mod.ctrl  }, 'a', function() tag_util.add() end,
              {description = 'add new', group = 'tag'}),
    -- Edit current tag
    awful.key({ mod.super, mod.ctrl  }, 'e',  function() tag_util.rename() end,
              {description = 'edit selected', group = 'tag'}),
    -- Move tag left
    awful.key({ mod.super, mod.ctrl }, '[', function() tag_util.move('left') end,
              {description = 'move left', group = 'tag'}),
    -- Move tag right
    awful.key({ mod.super, mod.ctrl }, ']', function() tag_util.move('right') end,
              {description = 'move right', group = 'tag'}),
    -- Delete current tag
    awful.key({ mod.super, mod.ctrl  }, 'd', function() tag_util.delete() end,
              {description = 'delete selected', group = 'tag'}),
})

-- Global: Layouts
awful.keyboard.append_global_keybindings({
    -- Next layout
    awful.key({ mod.super,           }, ']', function () awful.layout.inc( 1) end,
              {description = 'select next', group = 'layout'}),
    -- Previous layout
    awful.key({ mod.super,           }, '[', function () awful.layout.inc(-1) end,
              {description = 'select previous', group = 'layout'}),
})

-- Global: Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 1, function() menu_util.hide_all() end),
    awful.button({ }, 3, function() menu_util.hide_all() end),
})

-- Client
client.connect_signal('request::default_keybindings', function()
    awful.keyboard.append_client_keybindings({
        -- Toggle fullscreen
        awful.key({ mod.super, mod.shift }, 'f',
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = 'toggle fullscreen', group = 'client'}
        ),
        -- Toggle floating
        awful.key({ mod.super, mod.ctrl }, 'f',
            awful.client.floating.toggle,
            {description = 'toggle floating', group = 'client'}
        ),
        -- Toggle ontop
        awful.key({ mod.super, mod.ctrl }, 't',
            function(c)
                c.ontop = not c.ontop
            end,
            {description = 'toggle keep on top', group = 'client'}
        ),
        -- Toggle sticky
        awful.key({ mod.super, mod.ctrl }, 's',
            function(c)
                c.sticky = not c.sticky
            end,
            {description = 'toggle sticky', group = 'client'}
        ),
        -- Minimize client
        awful.key({ mod.super, }, 'n',
            function(c)
                c.minimized = true
            end,
            {description = 'minimize', group = 'client'}
        ),
        -- Toggle maximize
        awful.key({ mod.super, }, 'm',
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = '(un)maximize', group = 'client'}
        ),
        -- Toggle vertical maximize
        awful.key({ mod.super, mod.ctrl }, 'm',
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end ,
            {description = '(un)maximize vertically', group = 'client'}
        ),
        -- Toggle horizontal maximize
        awful.key({ mod.super, mod.shift }, 'm',
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end ,
            {description = '(un)maximize horizontally', group = 'client'}
        ),
        -- Swap with primary client
        awful.key({ mod.super, mod.shift }, 'p',
            function(c)
                c:swap(awful.client.getmaster())
            end,
            {description = 'swap with primary', group = 'client'}
        ),
        -- Move client to next screen
        awful.key({ mod.super, mod.shift }, 'o',
            function(c)
                c:move_to_screen()
            end,
            {description = 'move to screen', group = 'client'}
        ),
        -- Kill client (close)
        awful.key({ mod.super, mod.ctrl }, 'Escape',
            function(c)
                c:kill()
            end,
            {description = 'close', group = 'client'}
        ),
    })
end)

-- Client: Mouse bindings
client.connect_signal('request::default_mousebindings', function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = 'mouse_click' }
        end),
        awful.button({ mod.super }, 1, function (c)
            c:activate { context = 'mouse_click', action = 'mouse_move'  }
        end),
        awful.button({ mod.super }, 3, function (c)
            c:activate { context = 'mouse_click', action = 'mouse_resize'}
        end),
    })
end)
