#!/bin/bash -x

#declare dictionary array
declare -a positions

#variables
endGame=0
computerWinGame=0
userWinGame=0
positionChange=0
i=1
j=1

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
		computerWinGame=1
	else
		userWinGame=1
	fi
	endGame=1
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
	fi
}

#Function to playgame
function play()
{
   resetBoard
   toss

	endGame=0
	computerWinGame=0
	userWinGame=0

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
         checkWin
         currentPlayer=1
      fi
      if [[ $computerWinGame == 1 ]]
      then
         board
         echo "Computer won"
      elif [[ $userWinGame == 1 ]]
      then
         board
         echo "User won"
      fi
   done
}

#function for user turn
function userPlay()
{
   read -p "Enter position you want to add $userSymbol: " choice1
   while [ $(( ${positions["$choice1"]} )) -eq $(($computerSymbol)) -o $(( ${positions["$choice1"]} )) -eq $(($userSymbol)) ]
   do
      echo "Place already taken choose another one"
      read -p "Enter position you want to add $userSymbol: " choice1
   done
   positions["$choice1"]=$userSymbol
}

#Function for computer turn
function computerPlay()
{
	positionChange=0
 	checkComputerWin

	if [[ $positionChange == 0 ]]
	then
		checkUserWin
	fi

	if [[ $positionChange == 0 ]]
	then
		getCorner
	fi

	if [ $positionChange == 0 ]
	then
		getCenter
	fi

	if [ $positionChange == 0 ]
	then
		getRandomPosition
	fi
}

function checkComputerWin()
{
	i=1
	j=1
	while [ $i -le 9 -a $j -le 9 ]
   do
   	if [[ ${positions[$i]} == $i ]]
      then
      	positions[$i]=$computerSymbol
         checkWin
         if [[ $computerWinGame == 1 ]]
         then
         	echo "Entered computer"
            positionChange=1
            computerWinGame=0
            echo "Computer choose: $i"
            break
         else
            positions[$i]=$i
          fi
		fi
      i=$(( i + 1 ))
      j=$(( j + 1 ))
	done
}

function checkUserWin()
{
	i=1
	j=1
	while [ $i -le 9 -a $j -le 9 ]
   do
	   if [[ ${positions[$i]} == $i ]]
   	then
   		positions[$i]=$userSymbol
      	checkWin
      	if [[ $userWinGame == 1 ]]
      	then
      		echo "Entered user"
         	positionChange=1
         	computerWinGame=0
				userWinGame=0
         	positions[$i]=$computerSymbol
	         break
		else
      	   positions[$i]=$i
      fi
   fi
   i=$(( i + 1 ))
   j=$(( j + 1 ))
   done
}

#Function to get available corner
function getCorner()
{
	for ((i=1; i<=9; i=$(( i + 2)) ))
   do
	   if [[ $i = 5 ]]
   	then
   		continue
   	else
			if [[ ${positions[$i]} == $i ]]
   		then
				echo $computerWinGame
				checkWin
				computerWinGame=0
     			positionChange=1
     			positions[$i]=$computerSymbol
   	  		break
   		fi
		fi
   done
}

#Function to get center
function getCenter()
{
	if [[ ${positions[5]} == 5 ]]
  	then
   	checkWin
      computerWinGame=0
      positionChange=1
      positions[5]=$computerSymbol
      break
   fi
}

#Function to check for other position if nothing is available from corner & center
function getRandomPosition()
{
	choice=$(( $(($RANDOM % ${#positions[@]})) ))
   while [[ ${positions[$choice]} == $userSymbol && ${positions[$choice]} == $userSymbol ]]
   do
   	choice=$(($(($RANDOM % ${#positions[@]})) + 1))
      break
   done
   echo "Computer choose $choice"
   echo "Entered print"
   positions[$choice]=$computerSymbol
   board
}

#Function for play game & game over
function main()
{
	temp=0
	while [[ $temp != 1 ]]
	do
		printf "\nEnter your choice:\n1.Play Game\n2.Game Over\n"
		read -p "Choice: " choice
		case $choice in
			1)
				play
			;;
			2)
				temp=1
				printf "\n Game Over!!!! \nThank you for playing!!!"
				break
			;;
			*)
				printf "\n Invalid choice."
		esac
	done
}
main
