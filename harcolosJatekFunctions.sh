
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
} # pl.: draw 3 20 "-" $green

#ok 
load() {

	i=0
    	while IFS= read -r line
    	do
    	    #echo $i
    	    for ((j=0;j<$M;j++)) do
    	        matrix[$i,$j]=${line:$j:1}
    	    done
    	    ((i=i+1))
    	done < "$input"
}

getUserName() {
	read -p "monogram (two letter): " name
	case ${#name} in
	 0) ;;
	 1) UserName=$name;;
	 *) UserName=${name:0:2};;
	esac
}

#ok 
print_map() {
	for ((i=0;i<N;i++))
	do
	    for ((j=0;j<M;j++))
	    do
	    	    ((x=6+i))
	    	    ((y=20+j*2))
	    	    c=${matrix[$i,$j]}
		    case $c in
		        '#') draw $x $y '  ' $WALL;;
		        *) draw $x $y '  ' $AIR;;
		    esac
	    	    
	    done
	    echo
	done
	
}

update_entity_locations() {
	for ((i=0;i<N;i++))
	do
	    for ((j=0;j<M;j++))
	    do
	    	    ((x=6+i))
	    	    ((y=20+j*2))
	    	    c=${matrix[$i,$j]}
		    case $c in
		        'H') draw $x $y $UserName $HERO;;
		        [1-9]) draw $x $y "M$c" $MONSTER;;
		        *) ;;
		    esac
	    	    
	    done
	    echo
	done
}
