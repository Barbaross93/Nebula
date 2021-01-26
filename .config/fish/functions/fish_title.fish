# Defined in /tmp/fish.pi5dkm/fish_title.fish @ line 2
function fish_title
    # emacs is basically the only term that can't handle it.
    if not set -q INSIDE_EMACS
         if [ $_ = 'fish' ]
            echo -ns (whoami) '@' (cat /proc/sys/kernel/hostname) ':' (pwd | sed "s|^$HOME|~|")
         else
            echo $_
         end
    end
end
