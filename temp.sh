#!/bin/bash



clear	
source harcolosJatekFunctions.sh


declare -i alive 
alive=0
# signals
SIG_UP=USR1
SIG_RIGHT=USR2
SIG_DOWN=URG
SIG_LEFT=IO
SIG_QUIT=WINCH
SIG_DEAD=HUP

# direction arrays: 0=up, 1=right, 2=down, 3=left
move_r=([0]=-1 [1]=0 [2]=1 [3]=0)
move_c=([0]=0 [1]=1 [2]=0 [3]=-1)



move_and_draw() {
    echo -ne "\e[${1};${2}H$3"
}



is_dead() {
    
    return 1
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
       esac
    done
}
game_loop() {
    xc=10
    trap "xc=1;" $SIG_UP
    trap "xc=2;" $SIG_RIGHT
    trap "xc=3;" $SIG_DOWN
    trap "xc=4;" $SIG_LEFT
    trap "exit 1;" $SIG_QUIT
    while [ "$alive" -eq 0 ]; do
        draw $xc $xc 'c' "\e[30;43m"
        echo "a"
        sleep 0.03
    done
    
    echo -e "${text_color}Oh, No! You 0xdead$no_color"
    # signals the input loop that the snake is dead
    kill -$SIG_DEAD $$
}
game_loop &
game_pid=$!
getchar
exit 0
