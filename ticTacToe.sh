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
	board
}

#function toss to check who win toss
#Assign X & O symbols to computer and user.
function toss()
{
	random=$(( RANDOM % 2 ))
	if [ $random -eq 1 ]
	then
		currentPlayer=0
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
		currentPlayer=1
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

#Checking who win game
function whoWon()
{
	if [ $currentPlayer -eq 0 ]
	then
		echo "Computer won."
	else
		echo "User won."
	fi
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

#Function to check conditions vertical, diagonal, horizontal & tie for winner.
function checkWin()
{
	if [[ ${positions[1]} == ${positions[2]} && ${positions[2]} == ${positions[3]} ]]
	then
		whoWon
	elif [[ ${positions[4]} == ${positions[5]} && ${positions[5]} == ${positions[6]} ]]
	then
		whoWon
	elif [[ ${positions[7]} == ${positions[8]} && ${positions[8]} == ${positions[9]} ]]
	then
		whoWon
	elif [[ ${positions[1]} == ${positions[4]} && ${positions[4]} == ${positions[7]} ]]
	then
		whoWon
	elif [[ ${positions[2]} == ${positions[5]} && ${positions[5]} == ${positions[8]} ]]
	then
		whoWon
	elif [[ ${positions[3]} == ${positions[6]} && ${positions[6]} == ${positions[9]} ]]
	then
		whoWon
	elif [[ ${positions[1]} == ${positions[5]} && ${positions[5]} == ${positions[9]} ]]
	then
		whoWon
	elif [[ ${positions[7]} == ${positions[5]} && ${positions[5]} == ${positions[3]} ]]
	then
		whoWon
	elif [[ ${positions[1]} != 1 && ${positions[2]} != 2 && ${positions[3]} != 3 && ${positions[4]} != 4 && ${positions[5]} != 5 && ${positions[6]} != 6 && ${positions[7]} != 7 && ${positions[8]} != 8 && ${positions[9]} != 9 ]]
	then
		echo "The game is tie."
		endGame=1;
   else
		echo "Continue"
	fi
}

#Function for computer turn
function computerPlay()
{
	choice=$(( $(( $RANDOM % ${#positions[@]} )) ))
	while [ $((${positions["$choice"]})) -eq $(($userSymbol)) -o $((${positions["$choice"]})) -eq $(($userSymbol)) ]
	do
		choice=$(( $(( $RANDOM % ${#positions[@]} )) + 1))
	done
		echo "Computer choose $choice"
		positions["$choice"]=$computerSymbol
}

#function for user turn
function userPlay()
{
	read -p "Enter position you want to add $userSymbol: " choice1
	while [ $(( ${positions["$choice1"]} )) -eq $(($computerSymbol)) -o $((${positions["$choice1"]})) -eq $(($userSymbol)) ]
	do
		echo "Place already taken choose another one"
    	read -p "Enter position you want to add $userSymbol: " choice1
	done
	positions["$choice1"]=$userSymbol
}

#Function to playgame
function play()
{
	resetBoard
	toss
   endGame=0

	while [ $endGame -ne 1 ]
   do
   	board
   	if [ $currentPlayer -eq 1 ]
      then
      	userPlay
         checkWin
         currentPlayer=0
      else
      	computerPlay
         currentPlayer=1
      fi
	done
}

play
