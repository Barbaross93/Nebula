#!/bin/sh
### Zsh specific settings
# Completion
autoload -Uz compinit
compinit
unsetopt completealiases
zstyle ':completion:*' rehash true
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==35=35}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*:descriptions' format $'\e[01;33m %d\e[0m'
zstyle ':completion:*:messages' format $'\e[01;31m %d\e[0m'

# General opts
setopt autocd
unsetopt beep notify
bindkey -e
zstyle :compinstall filename '/home/barbaross/.config/zsh/.zshrc'

# History opts
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# hide division sign on incomplete line
PROMPT_EOL_MARK=''

# Make home/end/del keys work properly
bindkey  "^[[7~"   beginning-of-line
bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[8~"   end-of-line
bindkey  "^[[4~"   end-of-line
bindkey  "^[[3~"   delete-char
bindkey  "^[[5~"   up-line-or-history
bindkey  "^[[6~"   down-line-or-history

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='emacs'
fi

# Source stuff
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
. /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
. ~/.config/zsh/.p10k.zsh

# Startup zoxide
eval "$(zoxide init zsh)"

# fzf stuff
export FZF_BASE=/usr/bin/fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'  --color fg:7,bg:-1,hl:6,fg+:6,bg+:-1,hl+:6 --color info:2,prompt:1,spinner:5,pointer:5,marker:3,header:8'
source /usr/share/fzf/key-bindings.zsh


#for bat theme
export BAT_THEME="base16"

# Aliases
alias weather="curl 'wttr.in/?T'"
alias svim="sudoedit"
alias ip="ip --color=auto"
alias diff='diff --color=auto'
alias cht='f(){ curl -s "cheat.sh/$(echo -n "$*"|jq -sRr @uri)";};f'
alias l="exa -la"
alias ls="exa"
alias li="exa --icons"
alias clip="xclip -sel clip"
alias cp="cp --reflink" #to make lightweight copies w/ btrfs
alias tksv='tmux kill-server'
alias dotlink="stow --ignore='.git' --ignore='Scrots' --ignore='Boot' --ignore='.gitignore' --ignore='pkglist.txt' --ignore='README.md' -R --target=/home/barbarossa -d /home/barbarossa/Public/tower-dotfiles ."
alias fm="setsid -f nautilus ."
alias yayinst="yay -Slq | fzf -m --preview 'yay -Si {1}' | xargs -ro sudo yay -S"
alias cat="bat -p"
alias pfetch="curl -s https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch | sh"
alias doom="~/.emacs.d/bin/doom"
alias vim="emacs -nw"
alias emacs="emacs -nw"
alias yay="paru"
alias sshpi="ssh -p 5522 barbaross@192.168.0.2"
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....="cd ../../../.."
alias _="sudo"

### Functions
# Colorized man pages
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;40;35m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;33m") \
		man "$@"
}

e() {
  if [[ $# -eq 0 ]]; then
    /usr/bin/emacs # "emacs" is function, will cause recursion
    return
  fi
  args=($*)
  for ((i=0; i <= ${#args}; i++)); do
    local a=${args[i]}
    # NOTE: -c for creating new frame
    if [[ ${a:0:1} == '-' && ${a} != '-c' && ${a} != '--' ]]; then
      /usr/bin/emacs ${args[*]}
      return
    fi
  done
  setsid emacsclient -n -a /usr/bin/emacs ${args[*]}
}

# ls after a cd
cl() {
	local dir="$1"
	local dir="${dir:=$HOME}"
	if [[ -d "$dir" ]]; then
		cd "$dir" >/dev/null
		ls
	else
		echo "zsh: cl: $dir: Directory not found"
	fi
}

dotgit() {
	gitdir="/home/barbarossa/Public/tower-dotfiles/"
	git -C $gitdir add .
	git -C $gitdir commit -m "$*"
	git -C $gitdir push
}

# one off calculator
calc() {
	echo "scale=3;$@" | bc -l
}
