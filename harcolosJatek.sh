#!/bin/bash
clear

WALL="\e[30;43m"
AIR="\e[0m"
HERO="\e[0;44m" #blue
MONSTER="\e[0;41m" #red

text_yellow_bold="\033[1;33m"
text_yellow="\033[0;33m"
no_color="\e[0m"


#print properties
N=16
M=24

offsetX=6
offsetY=20

#global variables
UserName="ME"
life=3
moves=0
Hx=0
Hy=0
declare -A matrix
map_FILE="./map.txt"
game_FILE="./game.txt"
help_FILE="./help.txt"
RANDOM=$$

helpOn=0
loadq=0
quitq=0
saveq=0


# signals
SIG_UP=USR1
SIG_RIGHT=USR2
SIG_DOWN=URG
SIG_LEFT=IO

SIG_SAVE=ABRT
SIG_LOAD=BUS
SIG_QUIT=WINCH
SIG_DEAD=HUP
SIG_HELP=CONT

SIG_YES=ALRM
SIG_NO=FPE
	
source harcolosJatekFunctions.sh



#initialize game
getUserName
clear
load	
print_map
print_menu
update_userstat
create_entities
update_entity_locations



getchar() {
    trap "" SIGINT SIGQUIT
    trap "return;" $SIG_DEAD
    while true; do
        read -s -n 1 key
        case "$key" in
            [qQ]) kill -$SIG_QUIT $game_pid
                  ;;
            [wW]) kill -$SIG_UP $game_pid
                  ;;
            [dD]) kill -$SIG_RIGHT $game_pid
                  ;;
            [sS]) kill -$SIG_DOWN $game_pid
                  ;;
            [aA]) kill -$SIG_LEFT $game_pid
                  ;;
            [kK]) kill -$SIG_SAVE $game_pid
                  ;;
            [lL]) kill -$SIG_LOAD $game_pid
                  ;;
            [hH]) kill -$SIG_HELP $game_pid
                  ;;
            [yY]) kill -$SIG_YES $game_pid
                  ;;
            [nN]) kill -$SIG_NO $game_pid
                  ;;
       esac
    done
}
game_loop() {
    action=none
    trap "action=move_up;" $SIG_UP
    trap "action=move_right;" $SIG_RIGHT
    trap "action=move_down;" $SIG_DOWN
    trap "action=move_left;" $SIG_LEFT
    trap "action=save;" $SIG_SAVE
    trap "action=load;" $SIG_LOAD
    trap "action=help;" $SIG_HELP
    trap "action=yes;" $SIG_YES
    trap "action=no;" $SIG_NO
    trap "action=quit;" $SIG_QUIT
    while [ "$life" -gt 0 ]; do
    	case "$action" in
    	    *move*) qVarClear
    	    	  message " "
    	    	  if [ $helpOn -eq 0 ] ; then
	    	    	  move "$action"
	    	    	  update_userstat
	    	    	  # update_entity_locations # commented out for less cursor flecker
	    	    	  map_cleared # check if the hero cleared the map
	    	    	  if [ $? -eq 1 ]; then 
	    	    	  	message "You are the winner! The truth always stronger than the evil side."
	    	    	  	kill -$SIG_DEAD $$
	    	    	  	exit 0
	    	    	  fi
	    	  fi
    	    	  action=none
    	    	  ;;
    	    "save") qVarClear
    	    	  if [ -f "$game_FILE" ]; then
    	          	message "Are you sure?[Y/N] (the previously saved game will be overwritten)";
    	          	saveq=1
    	          else
    	          	save
    	    	  	qVarClear
    	    	  	message "game saved"; 
    	          fi   
    	    	  action=none
    	    	  ;;
    	    "help") qVarClear
    	    	  game_help   
    	    	  action=none
    	    	  ;;
    	    "load") qVarClear
    	          if [ -f "$game_FILE" ]; then
    	          	message "Are you sure?[Y/N] (current game datas will be lost)"; 
    	          	loadq=1
    	    	  
    	          else
    	          	message "no previous game (you must save the game first)"; 
    	          fi    	          
    	    	  action=none
    	    	  ;;
    	    "quit") qVarClear
    	          message "Do you want to save the game before quit [Y/N]";
    	          quitq=1
    	          action=none
    	    	  ;;
    	    "yes") if [ $loadq -eq 1 ] ; then
    	    	  	load game
    	    	  	update_userstat
    	    	  	update_entity_locations
    	    	  	qVarClear
    	    	  	message "game loaded"; 
    	    	  fi
    	    	  if [ $saveq -eq 1 ] ; then
    	    	  	save
    	    	  	qVarClear
    	    	  	message "game saved"; 
    	    	  fi
    	    	  if [ $quitq -eq 1 ] ; then
    	    	  	save
    	    	  	qVarClear
    	    	  	message "game saved"; 
    	    	  	kill -$SIG_DEAD $$
    	    	  	exit 1
    	    	  fi
    	    	  action=none
    	    	  ;;
    	    "no") 
    	    	  if [ $quitq -eq 1 ] ; then
    	    	  	kill -$SIG_DEAD $$
    	    	  	exit 1
    	    	  fi
    	    	  qVarClear
    	    	  message " "
    	    	  action=none
    	    	  ;;
    	esac
    	sleep 0.03
    done
    message "You lost (The hero was killed by strong monster(s))"
    kill -$SIG_DEAD $$
}
game_loop &
game_pid=$!
getchar
draw 30 1 "\n" $no_color #end of game
exit 0

