#!/bin/bash
clear

#color properties
#WALL="\e[30;100m"
#AIR="\e[30;103m"
WALL="\e[30;43m"
AIR="\e[0m"
HERO="\e[0;44m" #blue
MONSTER="\e[0;41m" #red

red="\e[0;41m"
green="\e[0;42m"
blue="\e[0;44m"
text_color="\e[31;43m"
no_color="\e[0m"


#print properties
N=16
M=24

offsetX=6
offsetY=20

#global variables
UserName="ME"
declare -A matrix
input="./map.txt"
RANDOM=$$
	
source harcolosJatekFunctions.sh







getUserName
load	
#matrix[1,1]='H'








create_entities(){
	hero_generated=0
	for ((i=0;i<N;i++))
	do
	    for ((j=0;j<M;j++))
	    do
	    	    c=${matrix[$i,$j]}
	    	    
	    	    if [ "$c" = ' ' ]; then
	    	    	R=$(($RANDOM%25))
	    	    	if [ $R -eq 0 ] && [ $hero_generated -eq 0 ]; then
	    	    	    matrix[$i,$j]='H'
	    	    	    hero_generated=1
	    	    	   
	    	    	elif [ $R -gt 22 ]; then
	    	    	    matrix[$i,$j]=$(($RANDOM%10))
	    	    	fi
	    	    fi
	    done
	done

}


# move hero //temp-ben müködő billenytű elkapás
# menu save/load/quit/change name/change color

print_map
create_entities
update_entity_locations









draw 30 1 "\n" $no_color #end of game
