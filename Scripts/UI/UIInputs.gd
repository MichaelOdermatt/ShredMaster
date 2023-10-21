extends Node2D

@onready var pauseMenu = get_node("../PauseMenuContainer");
@onready var progressManager = get_node("../../ProgressManager");

var isPaused = false;

func _input(event):
	# check to see if the player has pressed the reload scene button
	if event.is_action_pressed("Reload"):
		progressManager.resetAllValues();
		get_tree().reload_current_scene();
		get_tree().paused = false;
	elif event.is_action_pressed("Pause"):
		if (!isPaused):
			pauseMenu.visible = true;
			get_tree().paused = true;
		else:
			pauseMenu.visible = false;
			get_tree().paused = false;
		isPaused = !isPaused;
