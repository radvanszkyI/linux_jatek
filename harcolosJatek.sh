#!/bin/bash

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

UserName="ME"
declare -A matrix
input="./map.txt"
N=16
M=24

clear	
source harcolosJatekFunctions.sh







getUserName
load	
matrix[1,1]='H'

#update_entities
#todo generateEnemies
# move hero //temp-ben müködő billenytű elkapás
# menu save/load/quit/change name/change color

print_map
 
update_entity_locations









draw 30 1 "\n" $no_color #end of game
