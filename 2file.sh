#!/bin/bash

border_color="\e[30;43m"
green="\e[32;42m"
blue="\e[0;44m"
text_color="\e[31;43m"
no_color="\e[0m"
WALL='\u253C'

declare -A matrix
input="./map.txt"
N=16
M=24

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
    	        #echo ${line:$j:1} 
    	    done 
    	    ((i=i+1))
    	done < "$input"
}

#ok
print_matrix() {
	for ((i=0;i<N;i++))
	do
	    for ((j=0;j<M;j++))
	    do
	    	    ((x=8+i))
	    	    ((y=20+j*2))
	    	    c=${matrix[$i,$j]}
	    	    #echo -n "$x $y $c "
	    	    
		    draw $x $y $c$c $border_color
	    done
	    echo
	done
	
}


#type here your 2 letter monogram or just press enter(m="ME")

#ok
load	
#echo ${matrix[1,2]} # ez oké

print_matrix 
draw 9 22 "ME" $blue

#echo ${matrix[0,0]}
draw 30 1 "\n" $no_color #end of game
