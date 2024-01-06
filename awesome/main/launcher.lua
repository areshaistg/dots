local awful = require("awful")
local beautiful = require("beautiful")

return awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = Menu,
})
