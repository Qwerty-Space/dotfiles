# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import os
from shlex import quote

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command

class update_tmux_title(Command):
    """Sets the tmux title to ranger"""

    def execute(self):
        self.fm.run("tmux rename-window ranger")

import os
import subprocess

from ranger.api.commands import Command


class open_in_new_window(Command):
    """Opens the selected file(s) in nvim in a new tmux window or a new kitty window."""

    def execute(self):
        files = [f.path for f in self.fm.thistab.get_selection()]
        if not files:
            self.fm.notify("No file selected", bad=True)
            return

        # Window/tab name: the first file's basename, truncated to 20 characters,
        # with a "+N" suffix when more files are opened.
        name = os.path.basename(files[0])[:20]
        if len(files) > 1:
            name = f"{name} +{len(files) - 1}"

        cmds = []

        TERM = os.environ.get("TERM")

        if "tmux" in TERM:
            cmds.append(["tmux", "new-window", "-n", name, "nvim", *files])
        elif "kitty" in TERM:
            for f in files:
                name = os.path.basename(f)[:64]
                cmds.append(["kitty", "-1", "--title", name, "nvim", f])
        else:
            self.fm.notify("Not running in tmux or kitty", bad=True)
            return

        # Popen runs the command without blocking ranger's own terminal.
        for cmd in cmds:
            subprocess.Popen(
                cmd,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                start_new_session=True,
            )


class test_output(Command):
    """Outputs something"""

    def execute(self):
        print(self.fm.run("echo $TERM"))

class x_copy(Command):
    """ Copies a file to the x clipboard """

    def execute(self):
        cf = quote(self.fm.thisfile.path)
        self.fm.notify(cf)
        self.fm.run(f"xclip -se c -t $(file -b --mime-type {cf}) {cf}")
        self.fm.notify("Copied to x clipboard")

    def tab(self, tabnum):
        # tab completion
        return self._tab_directory_content()


class watch_episode(Command):
    """ Watch in mpv on specific tag 
    "mpv --fs --x11-name=watch --wayland-app-id=watch"
    """

    def execute(self):
        self.fm.run("mpv --fs --x11-name=watch --wayland-app-id=watch .", flags="f")

class tmsu_tag(Command):
    """:tmsu_tag

    Tags the current file with tmsu
    """

    def execute(self):
        cf = self.fm.thisfile

        self.fm.run("tmsu tag \"{0}\" {1}".format(cf.basename, self.rest(1)))

class tmsu_untag(Command):
    """:tmsu_untag

    Untags the current file with tmsu
    """

    def execute(self):
        cf = self.fm.thisfile

        self.fm.run("tmsu untag \"{0}\" {1}".format(cf.basename, self.rest(1)))

