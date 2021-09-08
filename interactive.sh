#!/usr/bin/env bash

cursor=0
count=0
menuItems=()

loadMenu() {
	commands=($(grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sort | awk '{print $1}' | sed 's/^\(.*\).$/\1/'))

	c=0
	for i in "${commands[@]}"
	do :
		menuItems[$c]=$(grep -E "^$i.*##" Makefile | awk 'BEGIN {FS = "##|[][]"}; {printf "\033[36m%-20s\033[0m %s \033[33m[\033[0m\033[32m%s\033[0m\033[33m]\033[0m\n", $1, $2, $3}')
		c=$((c+1))
	done

	count=${#menuItems[@]}
}

printMenu() {
    max=$(tput lines)
	max=$((max-4))

    start=0
    if [[ $cursor -gt $max ]]
	then
		start=$((cursor-max))
	fi

    num=$count
    if [[ $num -gt $max ]]
	then
		num=$((max+start))
	fi

	for ((i=$start; i<=$num; i++))
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

loadMenu

render() {
	clear
	echo -e "\e[32mhelp\e[0m: \e[33mq\e[0m - exit, \e[33mj\e[0m - down, \e[33mk\e[0m - up, \e[33ml\e[0m - select\n"
	printMenu
}

render

while true
do
	read -rsn1 key
	
	if [[ $key = "q" ]]
	then
		clear
		exit
	elif [[ $key = "j" && $cursor -lt $((count-1)) ]]
	then
		cursor=$((cursor+1))
		render
	elif [[ $key = "k" && $cursor -gt 0 ]]
	then
		cursor=$((cursor-1))
		render
	elif [[ $key = "l" && $cursor -gt 0 ]]
	then
		clear
		
		make ${commands[$cursor]}

		read -rsn1 key

		render
	fi
done

