# Defined in - @ line 1
function sshthanos --wraps='ssh cullen.ross@thanos.igs.umaryland.edu' --description 'alias sshthanos=ssh cullen.ross@thanos.igs.umaryland.edu'
  ssh cullen.ross@thanos.igs.umaryland.edu $argv;
end
