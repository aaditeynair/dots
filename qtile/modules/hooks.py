from libqtile import hook
import os
import subprocess


@hook.subscribe.startup_once
def autostart():
    script_path = os.path.expanduser("~/.config/qtile/scripts/startup.sh")
    subprocess.Popen([script_path])
