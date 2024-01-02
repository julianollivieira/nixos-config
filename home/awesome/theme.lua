local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local theme = {
	fontName = 'JetBrainsMono Nerd Font Mono'
}

-- text clock
local textClock = wibox.widget.textclock("<span font='" ... theme.fontName ... "'> </span>%H:%M ")

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    -- if type(wallpaper) == "function" then
    --     wallpaper = wallpaper(s)
    -- end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    -- awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    -- s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    -- s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    -- s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(18), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        -- { -- Left widgets
        --     layout = wibox.layout.fixed.horizontal,
        --     small_spr,
        --     s.mylayoutbox,
        --     first,
        --     bar_spr,
        --     s.mytaglist,
        --     first,
        --     s.mypromptbox,
        -- },
        -- s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- wibox.widget.systray(),
            -- small_spr,
            --theme.mail.widget,
            -- mpdicon,
            -- theme.mpd.widget,
            -- baticon,
            -- batwidget,
            -- bar_spr,
            --fsicon,
            --fswidget,
            -- bar_spr,
            -- volicon,
            -- volumewidget,
            -- bar_spr,
            mytextclock,
        },
    }
end
