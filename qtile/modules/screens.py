from libqtile.config import Screen
from libqtile.bar import Gap, Bar, STRETCH
from libqtile.widget import GroupBox, Clock, Spacer

screens = [
    Screen(
        wallpaper="/home/aadi/.config/qtile/assets/pink.jpg",
        wallpaper_mode="fill",
        # top=Bar(
        #     [
        #         Spacer(12),
        #         GroupBox(
        #             active="#618774",
        #             borderwidth=0,
        #             padding_x=12,
        #             inactive="#618774",
        #             highlight_method="text",
        #             font="JetBrainsMono NF",
        #             this_current_screen_border="#000",
        #         ),
        #         Spacer(STRETCH),
        #         Clock(
        #             foreground="#000",
        #             format="%a %d %b  %I:%M %p",
        #             font="JetBrainsMono NF",
        #         ),
        #         Spacer(24),
        #     ],
        #     38,
        #     border_width=3,
        #     margin=[24, 24, 12, 24],
        #     background="#faf4ed",
        # ),
        top=Gap(12),
        # bottom=Gap(12),
        left=Gap(12),
        right=Gap(12),
    )
]
