# Defined in - @ line 1
function paclab --wraps='sudo paclabel -Ls' --description 'alias paclab=sudo paclabel -Ls'
  sudo paclabel -Ls $argv;
end
