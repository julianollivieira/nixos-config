local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")
local dpi   = require("beautiful.xresources").apply_dpi

-- theme
local theme = {
	fg_normal                                 = "#FFFFFF",
	fg_focus                                  = "#0099CC",
	bg_focus                                  = "#303030",
	bg_normal                                 = "#242424",
	fg_urgent                                 = "#CC9393",
	bg_urgent                                 = "#006B8E",
	border_width                              = dpi(3),
	border_normal                             = "#252525",
	border_focus                              = "#0099CC",
	-- custom
	fontname = "JetBrainsMono Nerd Font Mono",
	c_font_size = "large",
	bar = gears.filesystem.get_configuration_dir() .. "icons/bar.png",
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
-- cputext = wibox.widget.textbox("<span font-size='" .. theme.c_font_size .. "' font='" .. theme.fontname .. "'><b>cpu</b></span>")
-- cpupercentagetext = wibox.widget.textbox("<span font-size='" .. theme.c_font_size .. "' font='" .. theme.fontname .. "'><b>$1 %</b></span>")
-- local cpupercentagetext = wibox.widget.textbox()
-- percentagesymboltext = wibox.widget.textbox("<span font-size='" .. theme.c_font_size .. "' font='" .. theme.fontname .. "'><b>%</b></span>")

-- local cpuwidget = wibox.widget { cputext, cpupercentagetext, spacing = 5, layout = wibox.layout.fixed.horizontal }
local cputext = wibox.widget.textbox()
local cpuwidget = wibox.container.margin(cputext, dpi(padding * 2), dpi(padding * 2))
local cpuwidget = wibox.container.background(cpuwidget, theme.bg_focus, gears.shape.rectangle)
local cpuwidget = wibox.container.margin(cpuwidget, 0, dpi(padding), dpi(padding), dpi(padding))

vicious.register(
	cputext,
	vicious.widgets.cpu,
	"<span font-size='" .. theme.c_font_size .. "' font='" .. theme.fontname .. "'><b>cpu $1%</b></span>",
	1
)

function theme.at_screen_connect(s)
    -- quake application
    -- s.quake = lain.util.quake({ app = awful.util.terminal })
		--
    gears.wallpaper.maximized(theme.wallpaper, s, true)

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
						cpuwidget,
						dtwidget,
            -- datewidget,
						-- bar,
            -- clockwidget,
        },
    }
end

return theme
