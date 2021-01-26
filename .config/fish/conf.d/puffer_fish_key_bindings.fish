bind . _puffer_fish_expand_dots
bind . -M insert _puffer_fish_expand_dots
bind ! _puffer_fish_expand_bang
bind ! -M insert _puffer_fish_expand_bang

set -l uninstall_event (basename (status -f) .fish)_uninstall

function $uninstall_event --on-event $uninstall_event
    bind -e .
    bind -e !
end
