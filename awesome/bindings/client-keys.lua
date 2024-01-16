local awful = require("awful")
local gears = require("gears")

local keybinds = require("utils.keybinds")

local key = keybinds.key
local group = keybinds.group()

do
    group "client" {
	["toggle fullscren"] = key({modkey}, "f", function(c)
	    c.fullscreen = not c.fullscreen
	    c:raise()
	end),
	["close"] = key({modkey, "Shift"}, "c", function(c)
	    c:kill()
	end),
	["toggle floating"] = key({modkey, "Control"}, "space", awful.client.floating.toggle),
	["move to master"] = key({modkey, "Control"}, "Return", function(c) c:swap(awful.client.getmaster()) end),
	["move to screen"] = key({modkey}, "o", function(c) c:move_to_screen() end),
	["toggle keep on top"] = key({modkey}, "t", function(c) c.ontop = not c.ontop end),
	["minimize"] = key({modkey}, "n", function(c) c.minimized = true end),
	["toggle maximize"] = key({modkey}, "m", function(c)
	    c.maximized = not c.maximized
	    c:raise()
	end),
	["(un)maximize vertically"] = key({modkey, "Control"}, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end),
	["(un)maximize horizontally"] = key({modkey, "Shift"}, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end),

    }

end

return group.get_keys()
