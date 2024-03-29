local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local textclock = wibox.widget.textclock()
local keyboardlayout = awful.widget.keyboardlayout()

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ Config.modkey }, 1, function(t)
	if client.focus then
	    client.focus:move_to_tag(t)
	end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ Config.modkey }, 3, function(t)
	if client.focus then
	    client.focus:toggle_tag(t)
	end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
	if c == client.focus then
	    c.minimized = true
	else
	    c:emit_signal(
	    "request::activate",
	    "tasklist",
	    {raise = true}
	    )
	end
    end),
    awful.button({ }, 3, function()
	awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({ }, 4, function ()
	awful.client.focus.byidx(1)
    end),
    awful.button({ }, 5, function ()
	awful.client.focus.byidx(-1)
    end)
)

awful.screen.connect_for_each_screen(function(s)
    s.mypromptbox = awful.widget.prompt()

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }


    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
	    keyboardlayout,
	    textclock,
            wibox.widget.systray(),
            s.mylayoutbox,
        },
    }
end)
