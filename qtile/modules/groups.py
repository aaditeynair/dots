from libqtile.config import DropDown, Group, ScratchPad

TERM_DROPDOWN = "alacritty --config-file /home/aadi/.config/alacritty/dropdown.yml "

groups = [
    ScratchPad(
        "scratchpad",
        [
            DropDown(
                "term", TERM_DROPDOWN, opacity=1, y=0.2, height=0.5, width=0.5, x=0.25
            ),
            DropDown(
                "ranger",
                TERM_DROPDOWN + "-e ranger",
                opacity=1,
                y=0.2,
                height=0.5,
                width=0.8,
                x=0.1,
            ),
            DropDown(
                "zfxtop",
                TERM_DROPDOWN,
                opacity=1,
                y=0.15,
                height=0.66,
                width=0.38,
                x=0.32,
            ),
        ],
    ),
    Group("Web", layout="columns"),
    Group("Terminal", layout="columns"),
    Group("Neovim", layout="columns"),
    Group("Music"),
]
