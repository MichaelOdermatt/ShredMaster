extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var isLeftAndRightMovementDisabled: bool = false;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# TODO (alternative to using area2D) could use get_slide_collision() here to check if the player is colliding with the rail
	# and if the player is colliding wit the rail set the players velocity to the rails but in the opposite direction. and dont let the player move.

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if (isLeftAndRightMovementDisabled):
		velocity.x = 55;
	else:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func enterRailMode():
	isLeftAndRightMovementDisabled = true;

func leaveRailMode():
	isLeftAndRightMovementDisabled = false;