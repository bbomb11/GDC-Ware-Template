extends Control

#DON'T EDIT, JUST FOR TESTING

#Basic testing code to let you test your game when passing in different difficulties,
#game speeds, and to make sure that the win/fail signals are presenting correctly

enum difficulty{
	easy,
	med,
	hard
}

#----------SET IN INSPECTOR---------------

@export var gameScene: PackedScene 
#Where you put your game scene to test

@export var setDifficulty: difficulty
#To chose the difficulty passed in

@export var setSpeed: float
#To set the game speed


#--------------------OTHER----------------------
#Visual Stuff
@onready var panel_player: AnimationPlayer = $CanvasLayer/Cover/AnimationPlayer
@onready var popUp_player: AnimationPlayer = $CanvasLayer/PopUp/AnimationPlayer
@onready var popUp: Label = $CanvasLayer/PopUp
@onready var color_rect: ColorRect = $CanvasLayer/Cover
@onready var progress_bar: ProgressBar = $CanvasLayer/PanelContainer/ProgressBar
@onready var start_button: Button = $CanvasLayer/StartButton

#Debug Labels
@onready var winon_end_state: Label = $CanvasLayer/VBoxContainer/WinonEndState
@onready var win_state: Label = $CanvasLayer/VBoxContainer/WinState
@onready var difficulty_label: Label = $CanvasLayer/VBoxContainer/DifficultyLabel
@onready var speed_label: Label = $CanvasLayer/VBoxContainer/SpeedLabel
@onready var time_remaining: Label = $CanvasLayer/VBoxContainer/TimeRemaining

#Timer Stuff
@onready var game_timer: Timer = $GameTimer
@onready var anim_timer: Timer = $AnimTimer

#Game state logic
var spawnScene: Node
var gameSpawned: bool
var gameActive: bool
var gameWon = false;
var gameFail = false;

func _ready() -> void:
	pass

func _process(delta: float) -> void: 
	if gameActive: #If thre game is running, set progress bar (and debug text)
		progress_bar.value = game_timer.time_left
		time_remaining.text = str(snapped(game_timer.time_left, 0.01))
		
	
	if Input.is_action_just_pressed("left_red_button") && !gameSpawned:
		GameStart(gameScene)
	


func checkWon():
	if spawnScene.winOnEnd == false:
		if gameWon && !gameFail: #If a game is complete by objective, and was beat, won
			GameWon()
			pass
		else: 
			GameFail()
			pass
	elif spawnScene.winOnEnd == true:
		if !gameFail: #If winOnEnd is true, game is beat only if fail is false
			GameWon()
			pass
		else:
			GameFail()
			pass

#Function called when game is won after being checked
func GameWon():
	win_state.text = "won"
	color_rect.color = Color.DARK_GREEN

#Function called when game is failed after being checked
func GameFail():
	win_state.text = "failed"
	color_rect.color = Color.DARK_RED


#Function called when signal fail is sent
func Fail():
	gameFail = true
	win_state.text = "fail: true"

#Function called when signal won is sent
func Won():
	gameWon = true;
	win_state.text = "win: true"

func GameStart(scene: PackedScene):
	
	#Spawn scene, and freeze it (until animation is done)
	spawnScene = scene.instantiate()
	spawnScene.process_mode = Node.PROCESS_MODE_DISABLED
	
	#Outs
	spawnScene.currentDifficulty = setDifficulty #Pass difficulty to child (root node script)
	
	#Ins (every reference to spawnScene.x pulls from the root child script, accessing a template variable)
	spawnScene.fail.connect(Fail)
	spawnScene.won.connect(Won)
	
	popUp.text = spawnScene.popUpVerb + "!"
	popUp.add_theme_color_override("font_color", spawnScene.popUpColour)
	
	var gameTime = (spawnScene.timeSet + 1) * 2 #as the enum works as an integer
	
	#Visuals/debug
	progress_bar.max_value = gameTime
	panel_player.play("OpenGame")
	
	difficulty_label.text = "Difficulty: " + str(setDifficulty)
	speed_label.text = "Speed: " + str(setSpeed)
	winon_end_state.text = "winOnEnd: " + str(spawnScene.winOnEnd)
	if spawnScene.winOnEnd:
		win_state.text = "fail: false"
	else:
		win_state.text = "win: false"
	
	start_button.visible = false
	
	#Reset game states
	gameFail = false
	gameWon = false
	
	#(set game engine runspeed every time the game starts)
	Engine.time_scale = setSpeed;
	AudioServer.playback_speed_scale = setSpeed;
	
	game_timer.wait_time = gameTime #Set game_timers wait time, to be later started once the animation is finished (on_anim_timer_timeout)

	
	#editables
	
	progress_bar.value = progress_bar.max_value
	anim_timer.start()
	
	add_child(spawnScene) #Add the spawnScene as a child of the root node, finally bringing it into the world
	gameSpawned = true #Game is spawned



#function when game is done
func GameDone():
	gameActive = false #Game done
	spawnScene.process_mode = Node.PROCESS_MODE_DISABLED #Pause the game
	
	checkWon() #Check win state
	
	panel_player.play("CloseGame") #Start the close animation
	anim_timer.start() #Timer which will stop the game after animation finishes (time set in inspector)
	pass


func _on_game_timer_timeout() -> void:
	GameDone()


#Timer to let animations finish playing
var destroyGame = false;
func _on_anim_timer_timeout() -> void:
	if destroyGame == false: #If a game scene exists, start the game
		spawnScene.process_mode = Node.PROCESS_MODE_INHERIT
		game_timer.start()
		popUp_player.play("PopUp")
		gameActive = true  #Game is being played
		destroyGame = true;
		
	else: #Otherwise, destroy the game
		spawnScene.queue_free()
		spawnScene = null
		
		start_button.visible = true;
		destroyGame = false;
		gameSpawned = false #Game destroyed


func _on_start_button_pressed() -> void:
	GameStart(gameScene)
