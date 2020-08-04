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

#function toss to check who win toss
function toss()
{
	random=$(( RANDOM % 2 ))
	if [ $random -eq 1 ]
	then
		echo "Computer won toss."
	else
		echo "You won toss."
	fi
}

resetBoard
toss
