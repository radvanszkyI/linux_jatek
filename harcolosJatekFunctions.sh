
#ok
draw() { # X, Y, char, bg-color 
	if [ $# -lt 0 ]
	  then
	    echo "Too few arguments"
	fi
	#szín nélkül
	if [ $# -eq 3 ]
	  then
	    echo -ne "\e[${1};${2}H$3"
	fi
	#háttérszínnel
	if [ $# -eq 4 ]
	  then
	    # karakter="$4$3$no_color"
	    echo -ne "\e[${1};${2}H$4$3$no_color"
	fi
} 

message(){
	draw $((offsetX+N+1)) 2 "                                                                            " $no_color
	draw $((offsetX+N+1)) 2 "$1" $no_color 
}

#ok 
load() { # map/game

	file="$map_FILE"
	if [ "$1" == "game" ]; then
		declare -gA matrix
		file="$game_FILE"
	fi
	i=0
    	while IFS= read -r line
    	do
    	    if [ $i -gt $N ] ; then
    	    	moves=$line
    	    elif [ $i -eq $N ] ; then
    	    	life=$line
    	    else
	    	for ((j=0;j<$M;j++)) do
	    	    matrix[$i,$j]=${line:$j:1}
	    	done
    	    fi
    	    ((i=i+1))
    	done < "$file"
}

save() {
	game_str="";
	for ((i=0;i<N;i++))
    	do
    	    for ((j=0;j<$M;j++)) do
    	        game_str+=${matrix[$i,$j]}
    	    done
    	    game_str+="\n"
    	done 
    	echo -e "${game_str}$life\n$moves" > "$game_FILE" #write game_str to file without the last '\n'
}

getUserName() {
	read -p "type here your monogram (two letter): " name
	case ${#name} in
	 0) ;;
	 1) UserName=$name;;
	 *) UserName=${name:0:2};; #maximum two character
	esac
}

#ok 
print_map() {
	for ((i=0;i<N;i++))
	do
	    for ((j=0;j<M;j++))
	    do
	    	    ((x=offsetX+i))
	    	    ((y=offsetY+j*2))
	    	    c=${matrix[$i,$j]}
		    case $c in
		        '#') draw $x $y '  ' $WALL;;
		        *) draw $x $y '  ' $AIR;;
		    esac
	    	    
	    done
	done
	
}

update_entity_locations() {

	for ((i=0;i<N;i++))
	do
	    for ((j=0;j<M;j++))
	    do
	    	    ((x=offsetX+i))
	    	    ((y=offsetY+j*2))
	    	    c=${matrix[$i,$j]}
		    case $c in
		        'H') draw $x $y $UserName $HERO ; Hx=$i ; Hy=$j ;;
		        [1-9]) draw $x $y "M$c" $MONSTER;;
		        '#') ;;
		        *) draw $x $y '  ' $AIR;;
		    esac
	    	    
	    done
	done
	message " " 
}

create_entities(){
	hero_generated=0
	for ((i=0;i<N;i++))
	do
	    for ((j=0;j<M;j++))
	    do
	    	    c=${matrix[$i,$j]}
	    	    if [ "$c" = ' ' ]; then
	    	    	R=$(($RANDOM%60))
	    	    	if [ $R -eq 0 ] && [ $hero_generated -eq 0 ]; then
	    	    	    matrix[$i,$j]='H'
	    	    	    hero_generated=1
	    	    	    Hx=$i ; Hy=$j
	    	    	elif [ $R -gt 53 ]; then
	    	    	    matrix[$i,$j]=$((($RANDOM%9+1)/($RANDOM%2+1)))
	    	    	fi
	    	    fi
	    done
	done
	#ha nincs hero
	if [ $hero_generated -eq 0 ]; then
		matrix[1,1]='H'
	fi
}

print_menu(){

    draw $((offsetX-3)) $offsetY 	 "Commands:   Q(quit)   K(save)   L(load)    H(help)" $no_color #end of game
    draw $((offsetX-2)) $offsetY 	 "   Moves:   W(up)     S(down)   D(right)   A(left)" $no_color #end of game
    if [ "$1" != "noUserInformation" ] ; then
    	draw $offsetX 3 "Name: $UserName\n\n Moves:\n\n    HP:" $text_yellow_bold 
    fi

}
game_help(){
	if [ $helpOn -eq 0 ] ; then
	    clear
	    print_menu noUserInformation
	    cat help.txt
    	fi
	
}

update_userstat(){
    #moves
    draw $((offsetX+2)) 9 "$moves" $text_yellow_bold 
    #hearts
    xk=0;yk=0;heartsInRow=4
    for ((i=0;i<life;i++)) do
    	((xk=offsetX+4+i/heartsInRow))
    	((yk=9+i%heartsInRow*2))
    	draw $xk $yk "\u2665" $text_yellow 
    done
    message " "
}
qVarClear(){ 
	loadq=0
	saveq=0
	loadq=0
}
move(){
	Nx=$Hx ; Ny=$Hy
	case "$1" in
	    *left) ((Ny--));; 
    	    *right)((Ny++)) ;; 
    	    *up) ((Nx--));; 
    	    *down) ((Nx++));; 
	esac
	if [ "$matrix[$Nx,$Ny]" != "#" ] ; then #if not wall then move
		matrix[$Nx,$Ny]="H"
		matrix[$Hx,$Hy]=" "
		((moves++))
		#if monster then fight
		
	fi
}

