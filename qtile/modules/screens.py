from libqtile.bar import Gap
from libqtile.config import Screen

screens = [
    Screen(
        wallpaper="/home/aadi/.config/qtile/assets/white.png",
        wallpaper_mode="fill",
        top=Gap(12),
        left=Gap(12),
        bottom=Gap(12),
        right=Gap(12),
    )
]
