# Defined in - @ line 1
function tksv --wraps='tmux kill-server' --description 'alias tksv tmux kill-server'
  tmux kill-server $argv;
end
