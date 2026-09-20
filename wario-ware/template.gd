extends Node
#Template script which the root node of your game scene must extend to have all the needed info

#------------Set in inspector--------------
enum timeBracket{
	time2s,
	time4s,
	time6s,
	time8s
}
@export var timeSet: timeBracket
#How much time alloted for the minigame (2, 4, 6, or 8 seconds)

@export var winOnEnd: bool 
#To make a survival based game, set to true
#To create an objective based game, set to false 
#If winOnEnd == true, losing a life happens when the fail signal is triggered, 
#If winOnEnd == false, losing a life happens unless the won signal is triggered

@export var popUpVerb: String 
#Action word used to describe what to do (! added automatically in post)

@export var popUpColour: Color
#Colour of popup text to allow contrast with game


#---------------Necessary Signals---------------
signal fail
#Signal to trigger losing a life when winOnEnd == true
#trigger with fail.emit()

signal won
#Signal to trigger completing the objective when winOnEnd == false
#trigger with won.emit()


#-----------------Optional-------------------------
enum difficulty{
	easy,
	med,
	hard
}
#Optional enum, allowing for differing difficulty states

var currentDifficulty = difficulty.easy
#currentDifficulty will be passed in by our system, 
#so if you want to add multiple difficulty states, simply 
#check the current state.
#(ex) if currentDifficulty == difficulty.med:
