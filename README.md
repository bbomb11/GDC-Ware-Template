# GDC-Ware-Template
Godot template for the University of Calgary's Game Design Club's GDC-ware project

Hello there cool game designer, this is the 2026/2027 edition of the hopefully annual project, where we all make a bunch of microgames together, and compile them all into one great game showcase!

 #Concept:
This project is a collaborative game development project where many members of the UCalgary Game Design Club community and beyond will create very short (2-8s) games, which will all be compiled by the GDC team to create a project together. 

This project is inspired by the WarioWare game series, so look into that if you’re wondering what the finished project will be similar to.

This year, the project is exclusively using the godot game engine’s latest version, 4.7.2. If you have a slightly earlier version of godot, it has good updating features, so it shouldn’t be much of a problem, but try to use a version that is close.

Microgames:
Each microgame is a short, bite-sized game that the player should be able to react to and figure out quickly, as they will only be playing it for a matter of seconds before transitioning to the next game. This doesn’t mean that there isn’t room for difficulty and creativity however, so make anything you’d like!!

Time
You are able to make a game of length 2, 4, 6, or 8 seconds within the provided template, which allows the beats of music to line-up. As the game continues, the engine will speed up using a speed multiplier, so make sure your game is made to be played within the amount of time chosen. For example, 2 seconds isn’t much time, so should be primarily reserved for reaction-time minigames. The larger times allow for a much larger variety in gameplay.

Input
As we are hoping to load the finished project into our arcade machine, we ask that you keep inputs to the directional buttons, as well as one primary and one secondary button.

Lives
Each game will be created with a fail / win condition in mind, such that if a game is failed, a life will be lost in the larger system. Games can either be made to win after the timer has elapsed, making them a survival type game, or they can be made to win once another condition has been met, losing upon the timer elapsing. 

Template
To use the template, there are 3 major components to keep in mind:

Godot (opening the template)
Games are to be created in godot, version 4.7.2 or similar. To open the template with godot, simply download the code as a zip, unzip the folder, and import the gdc-ware folder as a project into godot through the import button in the top-left of the launcher.

The project should automatically open to the Scene_Tester node in 3D view. To Properly view the scene, you’ll need to switch to the 2D scene view.

Scene Tester (our system)
This is the main scene where you can test your microgame with the inputs that our main system will input, as well as making sure your outputs are read correctly. This scene lets you make sure everything is functioning correctly to ensure a smooth transition into the full project when the time comes.

Input
The primary script on the Scene_Tester node has 3 editor inputs:
gameScene: PackedScene; 
This is the game you want to test in the system, which will be spawned when ready to play

setDifficulty: difficulty; 
This is the difficulty that is passed into the game. Difficulty is an optional parameter that will be passed to your game that you can decide what to do with. In the core system, difficulty will be increased incrementally at certain points.

setSpeed: float; 
This is the speed that the engine will be set to. In the core system, speed will be increased incrementally at certain points.

Using these 3 inputs, you can test your project to make sure the interactions are functional.

Output
When the start button is clicked (or primary button is pressed), gameScene is spawned. The system will then intake from your game these requirements:

timeSet: timeBracket;
This is the amount of time you want your game to be played for, either 2s, 4s, 6s, or 8s. The timer will be set to this amount of time.

winOnEnd: boolean;
This controls whether the system considers the timer running out to be a fail-state. If winOnEnd is false, the timer running out will be counted as a loss. If winOnEnd is true, the timer running out counts as a win.

popUpVerb: String;
popUpVerb: Color;
These are used to display the action word of what you are doing in your game. Colour is changeable so that you can set the colour of the text to contrast with your game.

won.emit();
fail.emit();
When these signals are cast, the system will register that the game is won or lost.

The Scene Tester will take all of these variables into account to spawn your game, play the popup animation of your desired verb, and detect if you won or lost the game based on your given state. If the panel is red / failed, a life would be lost, if the panel is green / won, a life would not be lost.

Your game
There are a couple of requirements in order to simplify the transition from your game to our system. 

Root Node Script
The root node of your scene must have a script which extends "res://template.gd" (like the example game does), as template.gd contains all of the required variables to make our system work. 

This script (on the root node) must be where won.emit() and fail.emit() are called. Other systems in the game can register your win or fail states, but they must pass the message of that state to the script on the root scene for us to detect this state.
Folder
Please have all dependencies for your game contained within one folder under res://, as ExampleScene1 is.
This will make file paths transfer easily and cleanly. This does not include the dependency on template.gd, which should stay where it within res://

Input
Input for this project will be done using the builtin "ui_left", "ui_right", "ui_up", and "ui_down" inputs for input axis (Left, Right, Up, Down arrow keys), 
“left_red_button” as the primary button (Z),
“right_blue_button” as the secondary button (X).

This is done so that inputs work consistently with our arcade machine. During testing, feel free to alter which buttons control these inputs through godots Input Map, and input styles / keybinds could change for the finalized system through this same Input Map.

Audio
If you plan on creating music, we request for all music tracks to be made at 120bpm so that the audio in the game can mesh smoothly. Keep the length of game you’re creating in mind when making your tracks. As well as custom-made tracks, we’ve created a few template tracks for you that you can use as well. Template tracks can be found here: https://drive.google.com/drive/folders/1lbATJEJH0sr-Wd0SRs7zpqwQglI4B7Wq?usp=drive_link
Currently, audio is sped-up using godot’s AudioServer.playback_speed_scale.

Out
Feel free to reach out to any executive on our discord server if you have any questions or need any clarification. 

We are open to pretty much any microgame as long as they are kind-hearted. 

Hopefully this template isn’t too restricting, as we’ve tried to keep everything relatively simple to create a microgame, as well as making everything simple to stitch together. With that, the project is open, and good luck!!
