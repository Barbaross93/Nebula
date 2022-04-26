# Auto start xorg
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  export XAUTHORITY="$HOME/.local/share/x11/xauthority"
  exec startx ~/.config/x11/xinitrc #&>/dev/null
fi
