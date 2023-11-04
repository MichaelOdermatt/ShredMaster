extends CharacterBody2D

const SPEED = 65.0;
const ACC = 6;
const DECC = 5;
const MAX_JUMP_HEIGHT = 60.0;
const MIN_JUMP_HEIGHT = 10.0;
const JUMP_DURATION = 0.35;
const HALF_SCREEN_WIDTH: int = 64;
## The max amount that the grind speed can decrease by while grinding
const MAX_GRIND_VELOCITY_DECREASE_VALUE = 50;

@onready var globals = get_node("/root/Globals");
@onready var playerRaycasts = $PlayerRaycasts;
@onready var playerInput = get_node("../PlayerInput");

var gravity: float;
var maxJumpVelocity: float;
var minJumpVelocity: float;

func _ready():
	# calculate the value of gravity and min/max jump heights
	gravity = 2 * MAX_JUMP_HEIGHT / pow(JUMP_DURATION, 2);
	maxJumpVelocity = -sqrt(2 * gravity * MAX_JUMP_HEIGHT);
	minJumpVelocity = -sqrt(2 * gravity * MIN_JUMP_HEIGHT);

func _physics_process(delta):
	var isGrinding = playerRaycasts.isPlayerGrindingRail();
	calcPlayerVelocity(delta, isGrinding);
	move_and_slide()

## Updates the CharacterBody2D's velocity property. Intended to be called in the _physics_process function.
func calcPlayerVelocity(delta: float, isGrinding: bool = false):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta;

	# Handle Jump.
	if playerInput.wasJumpJustPressed() and is_on_floor():
		velocity.y = maxJumpVelocity;
	if playerInput.wasJumpJustReleased() && velocity.y < minJumpVelocity:
		velocity.y = minJumpVelocity;

	# Get the input direction and handle the movement/deceleration.
	var direction = playerInput.getMovementInputDirection();
	if (isGrinding):
		velocity.x = calcGrindVelocity();
	else:
		if direction:
			velocity.x = move_toward(velocity.x, direction * SPEED, ACC);
		else:
			velocity.x = move_toward(velocity.x, 0, DECC);

# FOR RAIL GRINDING

## Calculates the grid velocity for the frame. If the player is past the halfway point on the 
## screen, their grid velocity will be lower than the rail's velocity in the opposite direction.
## This makes it look like the player is slowing down as they grind.
func calcGrindVelocity() -> float:
	var baseGrindVelocity = globals.currentBaseSpeed;

	var offsetFromCenter = clamp(transform.origin.x - HALF_SCREEN_WIDTH, 0, HALF_SCREEN_WIDTH);
	var grindVelocityDecrease = (offsetFromCenter / HALF_SCREEN_WIDTH) * MAX_GRIND_VELOCITY_DECREASE_VALUE;

	return baseGrindVelocity - grindVelocityDecrease;
