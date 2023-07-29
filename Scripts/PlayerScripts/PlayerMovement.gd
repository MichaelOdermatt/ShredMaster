extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const HALF_SCREEN_WIDTH: int = 64;
## The max amount that the grind speed can decrease by while grinding
const MAX_GRIND_VELOCITY_DECREASE_VALUE = 50;

@onready var globals = get_node("/root/Globals");

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var isGrinding = isPlayerGrindingRail();
	calcPlayerVelocity(delta, isGrinding);
	move_and_slide()

## Updates the CharacterBody2D's velocity property. Intended to be called in the
## _physics_process function.
func calcPlayerVelocity(delta: float, isGrinding: bool = false):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if (isGrinding):
		velocity.x = calcGrindVelocity();
	else:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

## Calculates the grid velocity for the frame. If the player is past the halfway point on the 
## screen, their grid velocity will be lower than the rail's velocity in the opposite direction.
## This creates the effect that the player is slowing down as they grind.
func calcGrindVelocity() -> float:
	var baseGrindVelocity = globals.RAIL_SPEED;

	var offsetFromCenter = clamp(transform.origin.x - HALF_SCREEN_WIDTH, 0, HALF_SCREEN_WIDTH);
	var grindVelocityDecrease = (offsetFromCenter / HALF_SCREEN_WIDTH) * MAX_GRIND_VELOCITY_DECREASE_VALUE;
	print_debug(offsetFromCenter);

	return baseGrindVelocity - grindVelocityDecrease;

## Returns true if the player is colliding with a rail object. Otherwise returns false.
func isPlayerGrindingRail() -> bool:
	var collisionCount = get_slide_collision_count();
	if (collisionCount == 0):
		return false;

	for index in collisionCount:
		var colliderName = get_slide_collision(index).get_collider().name;
		if (colliderName == "BasicRail"):
			return true;

	return false;
