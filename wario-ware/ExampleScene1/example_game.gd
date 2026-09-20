extends "res://template.gd" 
#Make sure your script extends "res://Template.gd", so that you have access to all of the proper variables
#Also be sure to put a script like this on your root scene node.
#Primary logic can be on other nodes, but the template variables must be set from the root scene node.
#similarly, the win/fail signal must be emit from the root node.

#time = time4s (set in editor)
#winOnEnd = false, as I want the player to succeed on completion, not on survival (set in editor)
#popUpVerb = "Shrink" (set in editor)
#popUpColour = black (set in editor)


#Resolution will be standard 16:9, 1080p, but feel free to mess with using side-bars or anything to have fun with it


#You can create your own variables and do whatever you want, these are very exampley
@onready var game_design_club: Sprite2D = $"Game Design Club" #Logo
var pressCount = 0.0; #Tallys presses
var maxPresses = 4.0; #Set within ready, but set to 4 for testing if no difficulty is passed

#Example of how one could scale with difficulty, although doing so is optional
func _ready() -> void:
	if (currentDifficulty == difficulty.easy):
		maxPresses = 4.0;
	elif (currentDifficulty == difficulty.med):
		maxPresses = 6.0;
	elif (currentDifficulty == difficulty.hard):
		maxPresses = 9.0;


#Key game logic
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_red_button"): #Custom input which maps to Z and the red arcade button
		pressCount += 1.0; #Increment
		if (pressCount == maxPresses): 
			won.emit(); #As winOnEnd == false, I want to emit a won signal
		
		#Simple visual logic to show pressing is doing something
		var scalar = maxf(((maxPresses - pressCount) / maxPresses) * 2.0, 0);
		game_design_club.scale = Vector2(scalar, scalar);
	
	
	if Input.is_action_just_pressed("right_blue_button"): #Custom input which maps to X and the blue arcade button
		#unused in this particular game
		pass
	
	#for arrow key/ joystick movment, use the builtin "ui_left", "ui_right", "ui_up", and "ui_down" inputs,
	#which map to the arrow keys and the arcade joystick
	
