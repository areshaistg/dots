pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")

require("main.error-handler")

beautiful.init(gears.filesystem.get_configuration_dir() .. "/deco/theme.lua")

Config = require("main.config")
modkey = Config.modkey
awful.layout.layouts = Config.layouts
beautiful.wallpaper = Config.wallpaper
menubar.utils.terminal = Config.terminal

Menu = require("main.menu")
Launcher = require("main.launcher")
Bar = require("main.bar")

Wallpaper = require("deco.wallpaper")

MouseBindings = require("bindings.mouse-bindings")
GlobalKeys = require("bindings.global-keys")
root.keys(GlobalKeys)
ClientKeys = require("bindings.client-keys")
ClientButtons = require("bindings.client-buttons")

Rules = require("main.rules")
awful.rules.rules = Rules

Signals = require("main.signals")
