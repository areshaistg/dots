local awful = require("awful")

local HOME = os.getenv("HOME")

local config = {
    terminal = "kitty",
    editor = "nvim",
    modkey = "Mod4",
    wallpaper = HOME .. "/Pictures/Wallpapers/great-wave-of-kanagawa-gruvbox.png",

    layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	awful.layout.suit.corner.nw,
	awful.layout.suit.floating,
    },
}


return config
