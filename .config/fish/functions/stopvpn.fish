# Defined in - @ line 1
function stopvpn --wraps='pkill openconnect' --description 'alias stopvpn=pkill openconnect'
  pkill openconnect $argv;
end
