# Defined in - @ line 1
function logout --wraps='kill -9 -1' --description 'alias logout=kill -9 -1'
  kill -9 -1 $argv;
end
