#!/bin/bash

border_color="\e[30;47m"
green="\e[32;42m"
blue="\e[0;44m"
text_color="\e[31;43m"
no_color="\e[0m"
WALL='\u253C'

UserName="ME"
declare -A matrix
input="./map.txt"
N=16
M=24

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
#ok nincsen benne a szoköz
load() {
	i=0
    	while IFS= read -r line
    	do
    	    #echo $i
    	    for ((j=0;j<$M;j++)) do
    	        matrix[$i,$j]=${line:$j:1}  
    	        c=${matrix[$i,$j]}
    	        #echo -n "$c " 
    	    done
    	    #echo
    	    ((i=i+1))
    	done < "$input"
}
print_matrix() {
	for ((i=0;i<N;i++))
	do
	    for ((j=0;j<M;j++))
	    do
	    	    ((x=8+i))
	    	    ((y=20+j*2))
	    	    c=${matrix[$i,$j]}
		    case $c in
		        '#') draw $x $y '  ' '\e[30;100m';;
		        ' ') draw $x $y '  ' $border_color;;
		    esac
	    	    
	    done
	    echo
	done
	
}
clear
load
#border_color="\e[30;100m"
#border_color="\e[30;43m"
#border_color="\e[30;40m"
#fal  ="\e[30;100m" ures ="\e[30;103m"
print_matrix	
