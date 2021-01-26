# Defined in - @ line 1
function startvpn --wraps='sudo openconnect vpn.som.umaryland.edu 2 >/dev/null &' --wraps='sudo openconnect vpn.som.umaryland.edu' --description 'alias startvpn=sudo openconnect vpn.som.umaryland.edu'
  sudo openconnect vpn.som.umaryland.edu $argv;
end
