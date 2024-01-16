local gears = require("gears")
local awful = require("awful")

local keybinds = {}

function keybinds.key(mods, key, callback)
    return {
	mods = mods,
	key = key,
	callback = callback,
    }
end

function keybinds.group()
    local myKeys = {}
    return setmetatable({
	get_keys = function()
	    return myKeys
	end
    }, {
	__call = function(_, name)
	    return function(keys)
		for desc, key in pairs(keys) do
		    gears.debug.print_error(key)
		    myKeys = gears.table.join(myKeys,
			awful.key(key.mods, key.key, key.callback, {description = desc, group = name})
		    )
		end
	    end
	end
    })
end

return keybinds
