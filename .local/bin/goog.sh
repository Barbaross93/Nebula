#!/bin/sh

# colorscheme for fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'  --color fg:7,bg:-1,hl:6,fg+:6,bg+:-1,hl+:6 --color info:2,prompt:1,spinner:5,pointer:5,marker:3,header:8'

n=0
x=1

query=$(echo "" | fzf --print-query --margin=40%,20% --reverse --border=horizontal --no-info --header=' ' --prompt ' | ' --pointer ' ' | grep "\S")

while :
do
	if [ $x -eq 1 ]; then
		json=$(googler --json --unfilter -s $n -x -n 50 "$query" | tee .google-json)
		count=$(cat .google-json | jq -r '.[] | .url' | wc -l)
		if [ $count -ge 41 ]; then
			peruse=$(cat .google-json | jq -r '.[] | .url' | sed -e '$aNext' | awk '{print NR-1 " " $0}' | fzf --with-nth 2.. --ansi --preview="if [[ {2} == \"Next\" ]]; then echo -e \"Next\nSee more results\" | sed \"1 s,.*,$(tput setaf 2)&$(tput sgr0),\"; elif [[ {2} == \"Prev\" ]]; then echo -e \"Previous\nSee previous results\" | sed \"1 s,.*,$(tput setaf 2)&$(tput sgr0),\"; else cat .google-json | jq -r '.[{1}] | .title,.abstract' | sed \"1 s,.*,$(tput setaf 2)&$(tput sgr0),\"; fi" --preview-window=up:3:wrap:noborder --reverse --border=horizontal --no-info --header=' ' --prompt ' | ' --pointer '― ' --phony | awk '{$1=""}1')
		else
			peruse=$(cat .google-json | jq -r '.[] | .url' | awk '{print NR-1 " " $0}' | fzf --with-nth 2.. --ansi --preview="if [[ {2} == \"Next\" ]]; then echo -e \"Next\nSee more results\" | sed \"1 s,.*,$(tput setaf 2)&$(tput sgr0),\"; elif [[ {2} == \"Prev\" ]]; then echo -e \"Previous\nSee previous results\" | sed \"1 s,.*,$(tput setaf 2)&$(tput sgr0),\"; else cat .google-json | jq -r '.[{1}] | .title,.abstract' | sed \"1 s,.*,$(tput setaf 2)&$(tput sgr0),\"; fi" --preview-window=up:3:wrap:noborder --reverse --border=horizontal --no-info --header=' ' --prompt ' | ' --pointer '― ' --phony | awk '{$1=""}1')
		fi	
	else
		json=$(googler --json --unfilter -s $n -x -n 50 "$query" | tee .google-json)
		count=$(cat .google-json | jq -r '.[] | .url' | wc -l)
		if [ $count -le 40 ]; then
			peruse=$(cat .google-json | jq -r '.[] | .url' | sed -e '$aPrev' | awk '{print NR-1 " " $0}' | fzf --with-nth 2.. --ansi --preview="if [[ {2} == \"Next\" ]]; then echo -e \"Next\nSee more results\" | sed \"1 s,.*,$(tput setaf 2)&$(tput sgr0),\"; elif [[ {2} == \"Prev\" ]]; then echo -e \"Previous\nSee previous results\" | sed \"1 s,.*,$(tput setaf 2)&$(tput sgr0),\"; else cat .google-json | jq -r '.[{1}] | .title,.abstract' | sed \"1 s,.*,$(tput setaf 2)&$(tput sgr0),\"; fi" --preview-window=up:3:wrap:noborder --reverse --border=horizontal --no-info --header=' ' --prompt ' | ' --pointer '― ' --phony | awk '{$1=""}1')
		else
			peruse=$(cat .google-json | jq -r '.[] | .url' | sed -e '$aNext' | sed -e '$aPrev' | awk '{print NR-1 " " $0}' | fzf --with-nth 2.. --ansi --preview="if [[ {2} == \"Next\" ]]; then echo -e \"Next\nSee more results\" | sed \"1 s,.*,$(tput setaf 2)&$(tput sgr0),\"; elif [[ {2} == \"Prev\" ]]; then echo -e \"Previous\nSee previous results\" | sed \"1 s,.*,$(tput setaf 2)&$(tput sgr0),\"; else cat .google-json | jq -r '.[{1}] | .title,.abstract' | sed \"1 s,.*,$(tput setaf 2)&$(tput sgr0),\"; fi" --preview-window=up:3:wrap:noborder --reverse --border=horizontal --no-info --header=' ' --prompt ' | ' --pointer '― ' --phony | awk '{$1=""}1')
		fi
	fi

	if [[ "$peruse" == " Next" ]]; then
		n=$(( $n + 50 ))
		x=$(( $x + 1 ))	
		continue
	elif [[ "$peruse" == " Prev" ]]; then
		n=$(( $n - 50 ))
		x=$(( $x - 1 ))		
		continue
	else
		linkhandler "$peruse"
		exit
	fi
done
