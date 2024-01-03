local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")
local dpi   = require("beautiful.xresources").apply_dpi

-- theme
local theme = {
	fontname = "JetBrainsMono Nerd Font Mono",
	-- bg_normal = "#0F0F0F",
	-- fg_normal = "#242424",
	-- bg_focus = "#2F2F2F",
	-- fg_focus = "#FFFFFF",
	-- custom
	c_font_size = "large",
	-- bg_lighter = "#2F2F2F",
	bar = gears.filesystem.get_configuration_dir() .. "icons/bar.png",
	--
	fg_normal                                 = "#FFFFFF",
	fg_focus                                  = "#0099CC",
	bg_focus                                  = "#303030",
	bg_normal                                 = "#242424",
	fg_urgent                                 = "#CC9393",
	bg_urgent                                 = "#006B8E",
	border_width                              = dpi(3),
	border_normal                             = "#252525",
	border_focus                              = "#0099CC",
	wallpaper = gears.filesystem.get_configuration_dir() .. "wallpaper.png",
}

local padding = 5
local bar = wibox.widget.imagebox(theme.bar)

-- date and time
local clock = wibox.widget.textclock("<span font-size='" .. theme.c_font_size .. "' font='" .. theme.fontname .. "'><b>%H:%M</b></span>")
local date = wibox.widget.textclock("<span font-size='" .. theme.c_font_size .. "' text-transform='lowercase' font='" .. theme.fontname .. "'><b>%a %d %b %Y</b></span>")
local dtwidget = wibox.widget { date, bar, clock, spacing = 5, layout = wibox.layout.fixed.horizontal }
local dtwidget = wibox.container.margin(dtwidget, dpi(padding * 2), dpi(padding * 2))
local dtwidget = wibox.container.background(dtwidget, theme.bg_focus, gears.shape.rectangle)
local dtwidget = wibox.container.margin(dtwidget, 0, dpi(padding), dpi(padding), dpi(padding))

-- cpu
-- local cpu = vicious.widgets.cpu

function theme.at_screen_connect(s)
    -- quake application
    -- s.quake = lain.util.quake({ app = awful.util.terminal })
		--
    gears.wallpaper.maximized(wallpaper, s, true)

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
		local layoutboxbg = wibox.container.background(layoutboxpadded, theme.bg_focus, gears.shape.rectangle)
		local layoutboxwidget = wibox.container.margin(layoutboxbg, dpi(padding), dpi(0), dpi(padding), dpi(padding))

		-- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

		local taglistpadded = wibox.container.margin(s.mytaglist, dpi(padding), dpi(padding), dpi(0), dpi(0))
		local taglistbg = wibox.container.background(taglistpadded, theme.bg_focus, gears.shape.rectangle)
		local taglistwidget = wibox.container.margin(taglistbg, dpi(0), dpi(padding), dpi(padding), dpi(padding))

		-- local dtpadded = wibox.container.margin(timeanddatewidget, dpi(padding), dpi(padding), dpi(0), dpi(0))
		-- local dtbg = wibox.container.background(dtpadded, theme.bg_lighter, gears.shape.rectangle)
		-- local dtwidget = wibox.container.margin(dtbg, dpi(0), dpi(0), dpi(padding), dpi(padding))

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
						-- cpu,
						dtwidget,
            -- datewidget,
						-- bar,
            -- clockwidget,
        },
    }
end

return theme
