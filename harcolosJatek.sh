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
text_yellow_bold="\033[1;33m"
text_yellow="\033[0;33m"
text_red="\033[0;31m"
no_color="\e[0m"


#print properties
N=16
M=24

offsetX=6
offsetY=20

#global variables
UserName="ME"
life=20
declare -A matrix
input="./map.txt"
RANDOM=$$
	
source harcolosJatekFunctions.sh

print_menu(){

    draw $((offsetX-3)) $offsetY "Commands:   Q(quit)   S(save)   L(load)" $no_color #end of game
    draw $((offsetX-2)) $offsetY "    Move:   W(up)     S(down)   D(right)   A(left)" $no_color #end of game
    draw $offsetX 2 "Name: $UserName\n\n   HP:" $text_yellow_bold 
    

}

update_lifes(){
    xk=0;yk=0;
    for ((i=0;i<life;i++)) do
    	((xk=offsetX+2+i/5))
    	((yk=8+i%5*2))
    	draw $xk $yk "\u2665" $text_yellow 
    done
}

getUserName
load	
print_map
#matrix[1,1]='H'


print_menu
update_lifes








# move hero //temp-ben müködő billenytű elkapás
# menu save/load/quit/change name/change color


create_entities
update_entity_locations









draw 30 1 "\n" $no_color #end of game
