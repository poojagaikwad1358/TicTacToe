#!/bin/bash -x

#declare dictionary array
declare -a positions

#Function to reset board
function resetBoard()
{
	for (( i=1; i<=9; i++ ))
	do
		positions[$i]=$i
	done
	echo "Board reset successful."
}
resetBoard
