#!/bin/bash



clear	
source harcolosJatekFunctions.sh


declare -i alive 
alive=1

# signals
SIG_UP=USR1
SIG_RIGHT=USR2
SIG_DOWN=URG
SIG_LEFT=IO

SIG_QUIT=WINCH
SIG_DEAD=HUP

SIG_FIGHT=ABRT




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
            [fF]) kill -$SIG_FIGHT $game_pid
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
    trap "action=fight;" $SIG_FIGHT
    trap "exit 1;" $SIG_QUIT
    while [ "$alive" -eq 1 ]; do
    	case "$action" in
    	    *move*) #move $action
    	    	  action=none;;
    	    fight) echo fight
    	    	  action=none;;
    	esac
    	
        sleep 0.03
    done
    
    #ha nem él kilép a ciklusból
    echo -e "Oh, No! You 0xdead"
    # signals the input loop that the snake is dead
    kill -$SIG_DEAD $$
}
game_loop &
game_pid=$!
getchar
exit 0
