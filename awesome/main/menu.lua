local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

local beautiful = require("beautiful")

local menu_entries = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", Config.terminal .. " -e man awesome" },
   { "edit config", Config.terminal .. "-e" .. Config.editor .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", menu_entries, beautiful.awesome_icon }
local menu_terminal = { "open terminal", Config.terminal }

if has_fdo then
    return freedesktop.menu.build({
	before = { menu_awesome },
	after = { menu_terminal }
    })
else
    return awful.menu({
	items = {
	    menu_awesome,
	    { "Debian", debian.menu.Debian_menu.Debian },
	    menu_terminal,
	}
    })
end
