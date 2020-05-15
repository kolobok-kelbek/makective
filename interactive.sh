#!/usr/bin/env bash

commands=($(grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sort | awk '{print $1}' | sed 's/^\(.*\).$/\1/'))

c=0
for i in "${commands[@]}"
do :
	menuItems[$c]=$(grep -E "^$i.*##" Makefile | awk 'BEGIN {FS = "##|[][]"}; {printf "\033[36m%-20s\033[0m %s \033[33m[\033[0m\033[32m%s\033[0m\033[33m]\033[0m\n", $1, $2, $3}')
	c=$((c+1))
done

count=${#menuItems[@]}

cursor=0

printMenu() {
	for ((i=0; i<$count; i++))
	do
		item=${menuItems[$i]}

		if [[ $cursor -eq $i ]]
		then
    		echo -e " \e[33m->\e[0m $item"
		else
			echo "    $item"
		fi
	done
}

while true
do
	clear
	echo -e "\e[32mhelp\e[0m: \e[33mq\e[0m - exit, \e[33mj\e[0m - down, \e[33mk\e[0m - up, \e[33ml\e[0m - select\n"
	printMenu
	
	

	read -n 1 key
	
	if [[ $key = "q" ]]
	then
		clear
		exit
	elif [[ $key = "j" && $cursor -lt $((count-1)) ]]
	then
		cursor=$((cursor+1))
	elif [[ $key = "k" && $cursor -gt 0 ]]
	then
		cursor=$((cursor-1))
	elif [[ $key = "l" && $cursor -gt 0 ]]
	then
		clear
		
		make ${commands[$cursor]}
		
		read -n 1
	fi
done

