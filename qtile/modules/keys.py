from libqtile.command import lazy
from libqtile.config import Key
import os

mod = "mod4"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Brightness and Volume Control
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 2%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 2%-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer sset Master toggle")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +2%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 2%-")),
    # Individual Apps
    # Key([mod], "backslash", lazy.spawn(f"betterlockscreen -l blur")),
    Key([mod], "Return", lazy.spawn("alacritty"), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    # Qtile
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Rofi
    Key(
        [mod],
        "r",
        lazy.spawn(os.path.expanduser("~/.config/rofi/launcher/launcher.sh")),
        desc="Run rofi as a launcher",
    ),
    Key(
        [mod],
        "slash",
        lazy.spawn(os.path.expanduser("~/.config/rofi/powermenu/powermenu.sh")),
        desc="Run rofi as the powermenu",
    ),
    # ScratchPads and Groups
    Key([mod], "t", lazy.group["scratchpad"].dropdown_toggle("term")),
    Key([mod], "i", lazy.group["scratchpad"].dropdown_toggle("ranger")),
    Key([mod], "g", lazy.group["scratchpad"].dropdown_toggle("zfxtop")),
    Key([mod], "a", lazy.group["a"].toscreen()),
    Key([mod], "s", lazy.group["s"].toscreen()),
    Key([mod], "d", lazy.group["d"].toscreen()),
    Key([mod], "f", lazy.group["f"].toscreen()),
    Key([mod, "shift"], "a", lazy.window.togroup("a")),
    Key([mod, "shift"], "s", lazy.window.togroup("s")),
    Key([mod, "shift"], "d", lazy.window.togroup("d")),
    Key([mod, "shift"], "f", lazy.window.togroup("f")),
    Key([mod], "o", lazy.spawn(os.path.expanduser("~/bin/time.sh"))),
]
