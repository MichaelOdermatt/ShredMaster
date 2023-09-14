extends Node2D

func _input(event):
	# check to see if the player has pressed the reload scene button
	if event.is_action_pressed("Reload"):
		get_tree().reload_current_scene();
