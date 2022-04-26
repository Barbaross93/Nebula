# Env settings
export XDG_CURRENT_DESKTOP="GNOME"

#New path
export PATH="/home/barbarossa/.local/bin:/home/barbarossa/.node_modules/bin:$PATH"

#default editor
export EDITOR="/usr/bin/emacs"
#export EDITOR="TERM=xterm-24bit /usr/bin/emacsclient -nw -s term"
#export SUDO_EDITOR="/usr/bin/emacs"

#Default browser
export BROWSER=/usr/bin/firefox

# Spotipy variables
export SPOTIPY_CLIENT_ID="$(pass spotipy/client_id)"
export SPOTIPY_CLIENT_SECRET="$(pass spotipy/client_secret)"
export SPOTIPY_REDIRECT_URI="http://localhost:8888/callback"

# Enable Neovide multigrid
export NEOVIDE_MULTIGRID=1

### Non-standard folder/file locations (moving out of the home dir)
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

#export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
export XDG_STATE_HOME="${HOME}/.local/state"

# xsession start script
export USERXSESSION="$XDG_CACHE_HOME/x11/xsession"
export USERXSESSIONRC="$XDG_CACHE_HOME/x11/xsessionrc"
export ALTUSERXSESSION="$XDG_CACHE_HOME/x11/Xsession"
export ERRFILE="$XDG_CACHE_HOME/x11/xsession-errors"

# Move bash history file
export HISTFILE="$XDG_STATE_HOME"/bash/history

# Move readline config
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# Move apsell configs
export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_CONFIG_HOME/aspell/en.pws; repl $XDG_CONFIG_HOME/aspell/en.prepl"

#Move vimrc
export MYVIMRC="${XDG_CONFIG_HOME}/vim/vimrc"
export VIMINIT="source ${MYVIMRC}"

#Move CUDA
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv

# Change zoom dir
export SSB_HOME="${XDG_DATA_HOME}/zoom"

# Change password store
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"

# Move rust dirs
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

# Move pylint dir
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"

# Move python history file
export PYTHONSTARTUP="${HOME}/.local/bin/startup.py"

# Move notmuch
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch/notmuchrc"

# Move gtk2 config
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"

# Disable less histfile
export LESSHISTFILE=-

# Move z data
export _Z_DATA="${XDG_DATA_HOME}/z"

# Move weechat home
export WEECHAT_HOME="${XDG_CONFIG_HOME}/weechat"

#Move isync's mbsync config (I think mutt-wizzard is the only one to recognize this)
export MBSYNCRC="${XDG_CONFIG_HOME}/isync/mbsyncrc"

# Move go directory
export GOPATH="${XDG_DATA_HOME}/go"

# Move vit dir
export VIT_DIR="${XDG_CONFIG_HOME}/vit"

# Move taskwarrior data and rc file
export TASKDATA="${XDG_DATA_HOME}/task"
export TASKRC="${XDG_CONFIG_HOME}/task/taskrc"

# Move terminfo database
export TERMINFO="$XDG_DATA_HOME"/terminfo

# Move timewarrior dir
export TIMEWARRIORDB="${XDG_CONFIG_HOME}/timewarrior"

#Move urxvt socket
export RXVT_SOCKET="/tmp/urxvtd"

#Move java home
export _JAVA_OPTIONS=-"Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java -Dsun.java2d.opengl=true"

### Deprecated (not needed but here for archival reasons)
# Enable trucolor in lf (needed for proper image previews w/ chafa)
export TCELL_TRUECOLOR=on

systemctl --user import-environment
