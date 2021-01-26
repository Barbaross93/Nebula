# Defined in - @ line 1
function clip --wraps='xclip -sel clip' --description 'alias clip=xclip -sel clip'
  xclip -sel clip $argv;
end
