# Defined in - @ line 1
function labels --wraps='paclabel -Ll' --description 'alias labels=paclabel -Ll'
  paclabel -Ll $argv;
end
