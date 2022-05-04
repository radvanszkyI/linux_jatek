#!/bin/bash

border_color="\e[30;43m"
green="\e[32;42m"
blue="\e[34;44m"
text_color="\e[31;43m"
no_color="\e[0m"
WALL='\u253C'

declare -A matrix
input="./tar.txt"
N=7
M=8

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


load() {
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

#todo
print_matrix() {
	for ((i=0;i<N;i++))
	do
	    for ((j=0;j<M;j++))
	    do
		    echo -n "${matrix[$i,$j]}_"
	    done
	    echo
	done
	
}


n=2;m=4

i=0


load	
#echo ${matrix[1,2]} # ez oké
print_matrix 

