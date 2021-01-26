# Defined in - @ line 1
function weather --wraps=curl\ \'wttr.in/\?T\' --description alias\ weather=curl\ \'wttr.in/\?T\'
  curl 'wttr.in/?T' $argv;
end
