#!/bin/bash
trap "tput cnorm; exit 0" INT
declare -i x=0
declare -i y=0
declare -i oldx=0
declare -i oldy=0
declare -i down=1
declare -i right=1
declare -i color=0
declare -air colors=(5 5 5 5 4 4 4 4 6 6 6 6 2 2 2 2 3 3 3 3 7 7 7 7 3 3 3 3 2 2 2 2 6 6 6 6 4 4 4 4)
tput bold
tput civis
while (true)
do
	sleep 0.02
	tput setaf ${colors[color]}
	((color++))
	((color%=${#colors[@]}))
	tput cup $oldy $oldx
	printf ' '
	tput cup $y $x
	printf '@'
	oldy=y
	oldx=x

	if (($down == 1)); then
		((y++))
	else
		((y--))
	fi

	if (($right == 1)); then
		((x++))
	else
		((x--))
	fi

	if (($y >= $LINES - 1)); then
		down=0
	fi
	if (($y <= 0)); then
		down=1
	fi

	if (($x >= $COLUMNS - 1)); then 
		right=0
	fi
	if (($x <= 0)); then
		right=1
	fi
	
done

