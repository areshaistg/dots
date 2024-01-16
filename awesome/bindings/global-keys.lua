local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local keybinds = require("utils.keybinds")

local key = keybinds.key
local group = keybinds.group()

do
    group "awesome" {
	["show help"] = key({modkey}, "s", hotkeys_popup.show_help),
	["restart"] = key({modkey, "Control"}, "r", awesome.restart),
	["quit awesome"] = key({modkey, "Shift"}, "q", awesome.quit),
	["lua execute prompt"] = key({modkey}, "x", function()
	    awful.prompt.run {
		prompt       = "Run Lua code: ",
		textbox      = awful.screen.focused().mypromptbox.widget,
		exe_callback = awful.util.eval,
		history_path = awful.util.get_cache_dir() .. "/history_eval"
	    }
	end),
    }

    group "tag" {
	["view previous"] = key({modkey}, "Left", awful.tag.viewprev),
	["view next"] = key({modkey}, "Right", awful.tag.viewnext),
	["go back"] = key({modkey}, "Escape", awful.tag.history.restore),
    }

    group "client" {
	["jump to urgent client"] = key({modkey}, "u", awful.client.urgent.jumpto),
	["focus next by index"] = key({modkey}, "j", function()
            awful.client.focus.byidx(1)
        end),
	["focus previous by index"] = key({modkey}, "k", function()
            awful.client.focus.byidx(-1)
        end),
	["swap with next client by index"] = key({modkey, "Shift"}, "j", function()
	    awful.client.swap.byidx(1)
	end),
	["swap with previous client by index"] = key({modkey, "Shift"}, "k", function()
	    awful.client.swap.byidx(-1)
	end),
	["focus the next screen"] = key({modkey, "Control"}, "j", function()
	    awful.screen.focus_relative(1)
	end),
	["focus the previous screen"] = key({modkey, "Control"}, "k", function()
	    awful.screen.focus_relative(-1)
	end),
	["go back"] = key({modkey}, "Tab", function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
	["restore minimized"] = key({modkey, "Control"}, "n", function()
	    local c = awful.client.restore()
	    -- Focus restored client
	    if c then
		c:emit_signal(
		"request::activate", "key.unminimize", {raise = true}
		)
	    end
	end),
    }

    group "launcher" {
	["open a terminal"] = key({modkey}, "Return", function() awful.spawn(Config.terminal) end),
	["launch rofi"] = key({modkey}, "r", function() awful.spawn("rofi -show run") end),
	["launch firefox"] = key({modkey}, "f", function() awful.spawn("firefox") end),
	["launch obsidian"] = key({modkey}, "o", function() awful.spawn("obsidian") end),
    }

    group "layout" {
	["increase master width factor"] = key({modkey}, "l", function() awful.tag.incmwfact(0.05) end),
	["decrease master width factor"] = key({modkey}, "h", function() awful.tag.incmwfact(-0.05) end),
	["increase the number of master clients"] = key({modkey, "Shift"}, "h", function()
	    awful.tag.incnmaster(1, nil, true)
	end),
	["decrease the number of master clients"] = key({modkey, "Shift"}, "l", function()
	    awful.tag.incnmaster(-1, nil, true)
	end),
	["increase the number of columns"] = key({modkey, "Control"}, "h", function()
	    awful.tag.incncol(1, nil, true)
	end),
	["decrease the number of columns"] = key({modkey, "Control"}, "l", function()
	    awful.tag.incncol(-1, nil, true)
	end),
	["select next"] = key({modkey}, "space", function()
	    awful.layout.inc(1)
	end),
	["select previous"] = key({modkey, "Shift"}, "space", function()
	    awful.layout.inc(-1)
	end),
    }
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do

    group "tag" {
	["view tag #" .. i] = key({modkey}, "#"..i + 9, function()
	    local screen = awful.screen.focused()
	    local tag = screen.tags[i]
	    if tag then
		tag:view_only()
	    end
	end),
	["toggle tag #" .. i] = key({modkey, "Control"}, "#"..i+9, function()
	    local screen = awful.screen.focused()
	    local tag = screen.tags[i]
	    if tag then
		awful.tag.viewtoggle(tag)
	    end
	end),
	["move client to tag #" .. i] = key({modkey, "Shift"}, "#"..i+9, function()
	    if client.focus then
		local tag = client.focus.screen.tags[i]
		if tag then
		    client.focus:move_to_tag(tag)
		end
	    end
	end),
	["toggle client on tag #" .. i] = key({modkey, "Shift", "Control"}, "#"..i+9, function()
	    if client.focus then
		local tag = client.focus.screen.tags[i]
		if tag then
		    client.focus:toggle_tag(tag)
		end
	    end
	end),
    }
end

return group.get_keys()
