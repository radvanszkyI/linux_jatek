#!/bin/bash

WALL="\e[30;43m"
AIR="\e[0m"
#WALL="\e[30;100m"
#AIR="\e[30;103m"


green="\e[32;42m"
blue="\e[0;44m"
text_color="\e[31;43m"
no_color="\e[0m"

UserName="ME"
declare -A matrix
input="./map.txt"
N=16
M=24

clear	
source harcolosJatekFunctions.sh


#ok todo: ME + Monsters
print_matrix() {
	for ((i=0;i<N;i++))
	do
	    for ((j=0;j<M;j++))
	    do
	    	    ((x=6+i))
	    	    ((y=20+j*2))
	    	    c=${matrix[$i,$j]}
		    case $c in
		        '#') draw $x $y '  ' $WALL;;
		        ' ') draw $x $y '  ' $AIR;;
		        'H') draw $x $y $UserName $blue;;
		    esac
	    	    
	    done
	    echo
	done
	
}

getUserName() {
	read -p "monogram (two letter): " name
	case ${#name} in
	 0) ;;
	 1) UserName=$name;;
	 *) UserName=${name:0:2};;
	esac
}


getUserName
load	
matrix[1,1]='H'

#todo generateEnemies
# move hero //temp-ben müködő billenytű elkapás
# menu save/load/quit/change name/change color

print_matrix 










draw 30 1 "\n" $no_color #end of game
