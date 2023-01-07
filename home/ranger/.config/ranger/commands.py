# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import os
from shlex import quote

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command


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
    """ Watch in mpv on specific tag """

    def execute(self):
        self.fm.execute_file(
            files=[f for f in self.fm.thistab.get_selection()],
            app="mpv",
            flags="--x11-name=watch")


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
