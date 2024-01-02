local gears = require("gears")
-- local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

-- theme
local theme = {
	fontname = "JetBrainsMono Nerd Font Mono",
	bg_normal = "#000000",
	fg_normal = "#FF00FF",
	bg_focus = "#111111",
}

-- text clock
local textclock = wibox.widget.textclock("<span font='" .. theme.fontname .. "'> </span>%H:%M ")
local clockbg = wibox.container.background(textclock, theme.bg_focus, gears.shape.rectangle)
local clockwidget = wibox.container.margin(clockbg, dpi(0), dpi(3), dpi(5), dpi(5))

function theme.at_screen_connect(s)
    -- quake application
    -- s.quake = lain.util.quake({ app = awful.util.terminal })

		-- setup top wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(18), bg = theme.bg_normal, fg = theme.fg_normal })
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            clockwidget,
        },
    }
end

return theme
