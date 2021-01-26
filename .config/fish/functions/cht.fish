function cht
    curl -s "cheat.sh/(echo -n "$argv" | jq -sRr @uri)"
end
