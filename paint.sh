#!/bin/bash
# Copyright (c) 2021 Mike Morrison
trap quit INT
declare -i x=0
declare -i y=0
declare -i color=0
paint () {
	printf ' '
	tput cup $y $x
}
move () {
	tput cup $y $x
}
quit () {
	tput rc
	exit 0
}
tput sc
clear
tput setab 0
tput setaf 7
printf 'Use WASD to paint.\nUse IJKL to move.\nUse '
for i in {0..7}; do
	tput setab $i
	if (($i == 7)); then
		tput setaf 0
	fi
	printf $i
done
tput setab 0
tput setaf 7
printf ' for colors.\nUse Q or Ctrl-C to quit.'
tput cup 0 0
tput setab 7
while (true)
do
	read -rsn1 input
	case $input in
		w|W)
		if (($y > 0)); then
			((y--))
			paint
		fi
			;;
		a|A)
		if (($x > 0)); then
			((x--))
			paint
		fi
			;;
		s|S)
		if (($y < $LINES - 1)); then
			((y++))
			paint
		fi
			;;
		d|D)
		if (($x < $COLUMNS - 1)); then
			((x++))
			paint
		fi
			;;
		i|I)
		if (($y > 0)); then
			((y--))
			move
		fi
			;;
		j|J)
		if (($x > 0)); then
			((x--))
			move
		fi
			;;
		k|K)
		if (($y < $LINES - 1)); then
			((y++))
			move
		fi
			;;
		l|L)
		if (($x < $COLUMNS - 1)); then
			((x++))
			move
		fi
			;;
		q|Q)
			quit
			;;
		[0-7])
			tput setab $input
			;;
	esac
	
done

