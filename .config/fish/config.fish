# Colored man pages
set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m") 

# Aliases to make thefuck aware of
set -x THEFUCK_OVERRIDDEN_ALIASES 'btop,doom,cat,clip,et,fm,stopvpn,startvpn,sshthanos,li,labels,paclab,svim,tksv,weather'

thefuck --alias | source
