from libqtile import layout
from libqtile.config import Match

layouts = [
    layout.Max(margin=12, border_width=3, border_focus="#000"),
    layout.Columns(
        margin=12,
        border_width=3,
        border_focus="#000",
        border_normal="#000",
        border_on_single=True,
    ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(margin=12, border_width=0),
    # layout.Matrix(),
    # layout.MonadTall(margin=12, border_width=0),
    # layout.MonadWide(margin=12, border_width=0),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

floating_layout = layout.Floating(
    border_width=3,
    border_focus="#000",
    border_normal="#000",
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
)
