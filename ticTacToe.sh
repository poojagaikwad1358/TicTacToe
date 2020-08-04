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
#Assign X & O symbols to computer and user.
function toss()
{
	random=$(( RANDOM % 2 ))
	if [ $random -eq 1 ]
	then
		echo "Computer won toss."

		symbol=$(( RANDOM % 2 ))
		if [ $symbol -eq 1 ]
		then
			computerSymbol='X'
			userSymbol='O'
		else
			computerSymbol='O'
			userSymbol='X'
		fi
	else
		echo "You won toss."

		read -p "Enter 1 for 'X' and 2 for 'O': " symbol
		if [ $symbol -eq 1 ]
		then
			userSymbol='X'
			computerSymbol='O'
		else
			userSymbol='O'
			computerSymbol='X'
		fi
	fi
	echo "Computer: $computerSymbol"
	echo "User: $userSymbol"
}

#Printing board
function board()
{
	printf "+---+---+---+\n"
   printf "| ${positions[1]} | ${positions[2]} | ${positions[3]} |\n"
	printf "+---+---+---+\n"
   printf "| ${positions[4]} | ${positions[5]} | ${positions[6]} |\n"
	printf "+---+---+---+\n"
   printf "| ${positions[7]} | ${positions[8]} | ${positions[9]} |\n"
	printf "+---+---+---+\n"
}

resetBoard
toss
board
