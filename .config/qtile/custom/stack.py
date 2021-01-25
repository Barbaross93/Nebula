# Copyright (c) 2008, Aldo Cortesi. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
import cairocffi

from libqtile import utils
from libqtile.layout.base import Layout, _ClientList
from libqtile.log_utils import logger

from xcffib.xproto import StackMode

from libqtile import configurable, drawer, pangocffi, window


# This is basically just libqtile/popup.py with the textlayout taken out and
# some extra functions to draw icons


class StackPreview(configurable.Configurable):
    """
    This class can be used to create popup windows that display images and/or text.
    """

    defaults = [
        ("opacity", 1.0, "Opacity of notifications."),
        ("foreground", "#ffffff", "Colour of text."),
        ("background", "#111111", "Background colour."),
        ("border", "#111111", "Border colour."),
        ("border_width", 0, "Line width of drawn borders."),
        ("corner_radius", None, "Corner radius for round corners, or None."),
        ("font", "sans", "Font used in notifications."),
        ("font_size", 14, "Size of font."),
        ("fontshadow", None, "Colour for text shadows, or None for no shadows."),
        ("horizontal_padding", 0, "Padding at sides of text."),
        ("vertical_padding", 0, "Padding at top and bottom of text."),
        ("margin", None, "Space around window as int or list of ints [N E S W]"),
        ("text_alignment", "left", "Text alignment: left, center or right."),
        ("wrap", True, "Whether to wrap text."),
    ]

    _icons_cache = {}

    def __init__(self, qtile, x=50, y=50, width=256, height=64, **config):
        configurable.Configurable.__init__(self, **config)
        self.add_defaults(StackPreview.defaults)
        self.qtile = qtile

        win = qtile.conn.create_window(x, y, width, height)
        win.set_property("QTILE_INTERNAL", 1)
        self.win = window.Internal(win, qtile)
        self.qtile.windows_map[self.win.window.wid] = self.win

        self.drawer = drawer.Drawer(
            self.qtile,
            self.win.window.wid,
            width,
            height,
        )

        if self.border_width:
            self.win.window.configure(borderwidth=self.border_width)
        if self.corner_radius:
            self.win.window.round_corners(
                width, height, self.corner_radius, self.border_width
            )

        self.win.handle_Expose = self._handle_Expose
        self.win.handle_KeyPress = self._handle_KeyPress
        self.win.handle_ButtonPress = self._handle_ButtonPress

        self.x = self.win.x
        self.y = self.win.y
        if not self.border_width:
            self.border = None

        self.orig_width = width

    def _handle_Expose(self, e):  # noqa: N802
        pass

    def _handle_KeyPress(self, event):  # noqa: N802
        pass

    def _handle_ButtonPress(self, event):  # noqa: N802
        if event.detail == 1:
            self.hide()

    @property
    def width(self):
        return self.win.width

    @width.setter
    def width(self, value):
        self.win.width = value
        self.drawer.width = value

    @property
    def height(self):
        return self.win.height

    @height.setter
    def height(self, value):
        self.win.height = value
        self.drawer.height = value

    def set_border(self, color):
        self.win.window.paint_borders(color)

    def clear(self):
        self.drawer.clear(self.background)

    def draw(self):
        self.drawer.draw()

    def place(self):
        self.win.place(
            self.x,
            self.y,
            self.width,
            self.height,
            self.border_width,
            self.border,
            above=False,
            margin=self.margin,
        )

    def unhide(self):
        self.win.unhide()
        self.win.window.configure(stackmode=StackMode.Below)

    def hide(self):
        self.win.hide()

    def kill(self):
        self.win.kill()

    def show_stack_icons(self, stack, current_win):
        self.stack = stack

        if not stack:
            logger.warning("Stack empty")
            clist.hide()
            return

        self.width = self.orig_width
        self.height = len(stack) * self.width

        offset = 0

        self.drawer.clear("000000")

        for client in stack:
            icon = self.get_window_icon(client)
            self.draw_icon(icon, offset)
            offset += self.width

        if current_win in stack:
            id = stack.index(current_win)
            self.drawer.set_source_rgb("00FFFF")
            self.drawer.rectangle(0, id * self.width, self.width, self.width)

        self.place()
        self.draw()
        self.unhide()

    def draw_icon(self, surface, offset):
        if not surface:
            return

        x = 2
        y = offset

        self.drawer.ctx.save()
        self.drawer.ctx.translate(x, y)
        self.drawer.ctx.set_source(surface)
        self.drawer.ctx.paint()
        self.drawer.ctx.restore()

    def get_window_icon(self, window):
        if not window.icons:
            return None

        self.icon_size = self.width - 4

        cache = self._icons_cache.get(window.window.wid)
        if cache:
            return cache

        icons = sorted(
            iter(window.icons.items()),
            key=lambda x: abs(self.icon_size - int(x[0].split("x")[0])),
        )
        icon = icons[0]
        width, height = map(int, icon[0].split("x"))

        img = cairocffi.ImageSurface.create_for_data(
            icon[1], cairocffi.FORMAT_ARGB32, width, height
        )

        surface = cairocffi.SurfacePattern(img)

        scaler = cairocffi.Matrix()

        if height != self.icon_size:
            sp = height / self.icon_size
            height = self.icon_size
            width /= sp
            scaler.scale(sp, sp)
        surface.set_matrix(scaler)
        self._icons_cache[window.window.wid] = surface
        return surface


class _WinStack(_ClientList):

    # shortcuts for current client and index used in Columns layout
    cw = _ClientList.current_client

    def __init__(self, autosplit=False):
        _ClientList.__init__(self)
        self.split = autosplit

    def toggle_split(self):
        self.split = False if self.split else True

    def __str__(self):
        return "_WinStack: %s, %s" % (
            self.cw,
            str([client.name for client in self.clients]),
        )

    def info(self):
        info = _ClientList.info(self)
        info["split"] = self.split
        return info


class Stack(Layout):
    """A layout composed of stacks of windows

    The stack layout divides the screen_rect horizontally into a set of stacks.
    Commands allow you to switch between stacks, to next and previous windows
    within a stack, and to split a stack to show all windows in the stack, or
    unsplit it to show only the current window.

    Unlike the columns layout the number of stacks is fixed.
    """

    defaults = [
        ("border_focus", "#0000ff", "Border colour for the focused window."),
        ("border_normal", "#000000", "Border colour for un-focused windows."),
        ("border_width", 1, "Border width."),
        ("name", "stack", "Name of this layout."),
        ("autosplit", False, "Auto split all new stacks."),
        ("num_stacks", 2, "Number of stacks."),
        ("fair", False, "Add new windows to the stacks in a round robin way."),
        ("margin", 0, "Margin of the layout (int or list of ints [N E S W])"),
        ("preview_width", 30, "Size of preview pane"),
    ]

    def __init__(self, **config):
        Layout.__init__(self, **config)
        self.add_defaults(Stack.defaults)
        self.stacks = [
            _WinStack(autosplit=self.autosplit) for i in range(self.num_stacks)
        ]

        self.qtile = None
        self.previews = {}

    @property
    def current_stack(self):
        return self.stacks[self.current_stack_offset]

    @property
    def current_stack_offset(self):
        for i, s in enumerate(self.stacks):
            if self.group.current_window in s:
                return i
        return 0

    @property
    def clients(self):
        client_list = []
        for stack in self.stacks:
            client_list.extend(stack.clients)
        return client_list

    def clone(self, group):
        c = Layout.clone(self, group)
        # These are mutable
        c.stacks = [_WinStack(autosplit=self.autosplit) for i in self.stacks]
        return c

    def _find_next(self, lst, offset):
        for i in lst[offset + 1 :]:
            if i:
                return i
        else:
            for i in lst[:offset]:
                if i:
                    return i

    def delete_current_stack(self):
        if len(self.stacks) > 1:
            off = self.current_stack_offset or 0
            s = self.stacks[off]
            self.stacks.remove(s)
            off = min(off, len(self.stacks) - 1)
            self.stacks[off].join(s, 1)
            if self.stacks[off]:
                self.group.focus(self.stacks[off].cw, False)

    def next_stack(self):
        n = self._find_next(self.stacks, self.current_stack_offset)
        if n:
            self.group.focus(n.cw, True)

    def previous_stack(self):
        n = self._find_next(
            list(reversed(self.stacks)),
            len(self.stacks) - self.current_stack_offset - 1,
        )
        if n:
            self.group.focus(n.cw, True)

    def focus(self, client):
        for i in self.stacks:
            if client in i:
                i.focus(client)

    def focus_first(self):
        for i in self.stacks:
            if i:
                return i.focus_first()

    def focus_last(self):
        for i in reversed(self.stacks):
            if i:
                return i.focus_last()

    def focus_next(self, client):
        iterator = iter(self.stacks)
        for i in iterator:
            if client in i:
                next = i.focus_next(client)
                if next:
                    return next
                break
        else:
            return

        for i in iterator:
            if i:
                return i.focus_first()

    def focus_previous(self, client):
        iterator = iter(reversed(self.stacks))
        for i in iterator:
            if client in i:
                next = i.focus_previous(client)
                if next:
                    return next
                break
        else:
            return

        for i in iterator:
            if i:
                return i.focus_last()

    def add(self, client):
        for i in self.stacks:
            if not i:
                i.add(client)
                return
        if self.fair:
            target = min(self.stacks, key=len)
            target.add(client)
        else:
            self.current_stack.add(client)

    def remove(self, client):
        current_offset = self.current_stack_offset
        for i, stack in enumerate(self.stacks):
            if client in stack:
                stack.remove(client)
                preview = self.previews.get(i)
                if preview:
                    preview.hide()
                break
        if self.stacks[current_offset].cw:
            return self.stacks[current_offset].cw
        else:
            n = self._find_next(
                list(reversed(self.stacks)), len(self.stacks) - current_offset - 1
            )
            if n:
                return n.cw

    def configure(self, client, screen_rect):
        if not self.qtile:
            from libqtile import qtile

            self.qtile = qtile

        for i, s in enumerate(self.stacks):
            if client in s:
                break
        else:
            client.hide()
            return

        if client.has_focus:
            px = self.border_focus
        else:
            px = self.border_normal

        column_width = int(screen_rect.width / len(self.stacks))
        xoffset = screen_rect.x + i * column_width
        window_width = column_width - 2 * self.border_width - self.preview_width

        if s.split:
            column_height = int(screen_rect.height / len(s))
            window_height = column_height - 2 * self.border_width
            yoffset = screen_rect.y + s.index(client) * column_height
            client.place(
                xoffset,
                yoffset,
                window_width,
                window_height,
                self.border_width,
                px,
                margin=self.margin,
            )
            client.unhide()
        else:
            if client == s.cw:
                client.place(
                    xoffset + self.preview_width,
                    screen_rect.y,
                    window_width,
                    screen_rect.height - 2 * self.border_width,
                    self.border_width,
                    px,
                    margin=self.margin,
                )
                client.unhide()
            else:
                client.hide()

            if self.qtile:
                preview = self.previews.get(i)
                if not preview:
                    preview = StackPreview(
                        self.qtile,
                        xoffset,
                        screen_rect.y,
                        self.preview_width,
                        screen_rect.height,
                        margin=self.margin,
                    )
                    self.previews[i] = preview

            if preview:
                preview.show_stack_icons(self.stacks[i], s.cw)

    def info(self):
        d = Layout.info(self)
        d["stacks"] = [i.info() for i in self.stacks]
        d["current_stack"] = self.current_stack_offset
        d["clients"] = [c.name for c in self.clients]
        return d

    def cmd_toggle_split(self):
        """Toggle vertical split on the current stack"""
        self.current_stack.toggle_split()
        self.group.layout_all()

    def cmd_down(self):
        """Switch to the next window in this stack"""
        self.current_stack.current_index += 1
        self.group.focus(self.current_stack.cw, False)

    def cmd_up(self):
        """Switch to the previous window in this stack"""
        self.current_stack.current_index -= 1
        self.group.focus(self.current_stack.cw, False)

    def cmd_shuffle_up(self):
        """Shuffle the order of this stack up"""
        self.current_stack.shuffle_up()
        self.group.layout_all()

    def cmd_shuffle_down(self):
        """Shuffle the order of this stack down"""
        self.current_stack.shuffle_down()
        self.group.layout_all()

    def cmd_delete(self):
        """Delete the current stack from the layout"""
        self.delete_current_stack()

    def cmd_add(self):
        """Add another stack to the layout"""
        newstack = _WinStack(autosplit=self.autosplit)
        if self.autosplit:
            newstack.split = True
        self.stacks.append(newstack)
        self.group.layout_all()

    def cmd_rotate(self):
        """Rotate order of the stacks"""
        utils.shuffle_up(self.stacks)
        self.group.layout_all()

    def cmd_next(self):
        """Focus next stack"""
        return self.next_stack()

    def cmd_previous(self):
        """Focus previous stack"""
        return self.previous_stack()

    def cmd_client_to_next(self):
        """Send the current client to the next stack"""
        return self.cmd_client_to_stack(self.current_stack_offset + 1)

    def cmd_client_to_previous(self):
        """Send the current client to the previous stack"""
        return self.cmd_client_to_stack(self.current_stack_offset - 1)

    def cmd_client_to_stack(self, n):
        """
        Send the current client to stack n, where n is an integer offset.  If
        is too large or less than 0, it is wrapped modulo the number of stacks.
        """
        if not self.current_stack:
            return
        next = n % len(self.stacks)
        win = self.current_stack.cw
        self.current_stack.remove(win)
        self.stacks[next].add(win)
        self.stacks[next].focus(win)
        self.group.layout_all()

    def cmd_info(self):
        return self.info()
