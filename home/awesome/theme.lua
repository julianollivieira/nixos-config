local gears = require("gears")
-- local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

-- theme
local theme = {
	fontname = "JetBrainsMono Nerd Font Mono",
	bg_normal = "#0F0F0F",
	fg_normal = "#AAAAAA",
	bg_focus = "#2F2F2F",
	fg_focus = "#FFFFFF",
	-- custom
	bg_lighter = "#1F1F1F",
}

local padding = 5

-- text clock
local textclock = wibox.widget.textclock("<span font='" .. theme.fontname .. "'><b>%H:%M</b></span>")
local textclockpadded = wibox.container.margin(textclock, dpi(padding), dpi(padding))
local clockbg = wibox.container.background(textclockpadded, theme.bg_lighter, gears.shape.rectangle)
local clockwidget = wibox.container.margin(clockbg, dpi(0), dpi(padding), dpi(padding), dpi(padding))

function theme.at_screen_connect(s)
    -- quake application
    -- s.quake = lain.util.quake({ app = awful.util.terminal })

		-- setup tag table
		awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

		-- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

		local layoutboxpadded = wibox.container.margin(s.mylayoutbox, dpi(padding), dpi(padding), dpi(0), dpi(0))
		local layoutboxbg = wibox.container.background(layoutboxpadded, theme.bg_lighter, gears.shape.rectangle)
		local layoutboxwidget = wibox.container.margin(layoutboxbg, dpi(padding), dpi(0), dpi(padding), dpi(padding))

		-- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

		local taglistpadded = wibox.container.margin(s.mytaglist, dpi(padding), dpi(padding), dpi(0), dpi(0))
		local taglistbg = wibox.container.background(taglistpadded, theme.bg_lighter, gears.shape.rectangle)
		local taglistwidget = wibox.container.margin(taglistbg, dpi(0), dpi(0), dpi(padding), dpi(padding))

		-- setup top wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(32), bg = theme.bg_normal, fg = theme.fg_normal })
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
				{
            layout = wibox.layout.fixed.horizontal,
						layoutboxwidget,
						taglistwidget,
				},
				nil,
        {
            layout = wibox.layout.fixed.horizontal,
            clockwidget,
        },
    }
end

return theme
