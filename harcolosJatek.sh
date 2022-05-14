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
life=4
declare -A matrix
map_FILE="./map.txt"
game_FILE="./game.txt"
RANDOM=$$
loadq=0

# signals
SIG_UP=USR1
SIG_RIGHT=USR2
SIG_DOWN=URG
SIG_LEFT=IO

SIG_SAVE=ABRT
SIG_LOAD=BUS
SIG_QUIT=WINCH
SIG_DEAD=HUP
	
source harcolosJatekFunctions.sh



#initialize game
getUserName
load	
print_map
print_menu
update_lifes
create_entities
update_entity_locations



move(){
	case "$action" in
	    *left) ;; 
    	    *right) ;; 
    	    *up) ;; 
    	    *down) ;; 
	esac
}




getchar() {
    trap "" SIGINT SIGQUIT
    trap "return;" $SIG_DEAD
    while true; do
        read -s -n 1 key
        case "$key" in
            [qQ]) kill -$SIG_QUIT $game_pid
                  return
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
            [yY]) if [ $loadq -eq 1 ]; then 
            		load game
            		loadq=0
                  fi
                  ;;
            [nN]) if [ $loadq -eq 1 ]; then 
            		message " "
            		loadq=0
                  fi
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
    trap "exit 1;" $SIG_QUIT
    while [ "$life" -gt 1 ]; do
    	case "$action" in
    	    *move*) move "$action"
    	    	  action=none;;
    	    save) save
    	    	  action=none;;
    	    load) 
    	          message "Are you sure?[Y/N] (current game datas will be lost)"
    	    	  loadq=1
    	    	  action=none;;
    	esac
# move hero //temp-ben müködő billenytű elkapás
# S -> save
# L -> (biztos?jelenlegi elveszik) load game
        sleep 0.03
    done
    
    #if no life then stop the game
    echo -e "Oh, No! You 0xdead"
    
    # signals the input loop that the hero is dead
    kill -$SIG_DEAD $$
}
game_loop &
game_pid=$!
getchar
exit 0








draw 30 1 "\n" $no_color #end of game
