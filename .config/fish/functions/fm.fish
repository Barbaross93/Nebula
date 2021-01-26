# Defined in - @ line 1
function fm --wraps='setsid -f thunar' --description 'alias fm=setsid -f thunar'
  setsid -f thunar $argv;
end
