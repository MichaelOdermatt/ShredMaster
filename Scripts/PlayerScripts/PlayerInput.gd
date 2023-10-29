extends Node2D

signal movement_key_just_pressed_or_released();
signal jump_key_just_pressed();

func _input(event):
	var justPressed = (event.is_action_pressed("MoveRight") || event.is_action_pressed("MoveLeft")) && !event.is_echo();
	var justReleased = (event.is_action_released("MoveLeft") || event.is_action_released("MoveRight"));
	if justPressed || justReleased:
		emit_signal("movement_key_just_pressed_or_released");
	
	elif wasJumpJustPressed():
		emit_signal("jump_key_just_pressed");


## Returns true if the player just pressed the jump button.
func wasJumpJustPressed() -> bool:
	return Input.is_action_just_pressed("Jump");

## Returns true if the player just released the jump button.
func wasJumpJustReleased() -> bool:
	return Input.is_action_just_released("Jump");

## Returns the left / right player input direction. 1 is right, -1 is left, 0 is neither.
func getMovementInputDirection() -> float:
	return Input.get_axis("MoveLeft", "MoveRight");