extends CharacterBody2D

const SPEED = 80.0;
const ACC = 7;
const DECC = 5;
const MAX_JUMP_HEIGHT = 80.0;
const MIN_JUMP_HEIGHT = 15.0;
const JUMP_DURATION = 0.40;
const HALF_SCREEN_WIDTH: int = 64;
## The max amount that the grind speed can decrease by while grinding
const MAX_GRIND_VELOCITY_DECREASE_VALUE = 50;

@onready var globals = get_node("/root/Globals");
@onready var playerSprite = get_node("PlayerSprite");
@onready var playerRaycasts = $PlayerRaycasts;
@onready var playerParticleEffects = get_node("../PlayerParticleEffects");
@onready var playerSounds = get_node("../PlayerSounds");

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
	handlePlayerMovementSounds(isGrinding);
	calcPlayerVelocity(delta, isGrinding);
	move_and_slide()

## Updates the CharacterBody2D's velocity property. Intended to be called in the
## _physics_process function.
func calcPlayerVelocity(delta: float, isGrinding: bool = false):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta;

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = maxJumpVelocity;
	if Input.is_action_just_released("Jump") && velocity.y < minJumpVelocity:
		velocity.y = minJumpVelocity;

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if (isGrinding):
		velocity.x = calcGrindVelocity();
		playerSprite.playGrindAnimation();
		playerParticleEffects.startEmittingSparkParticles(transform.origin);
	else:
		playerParticleEffects.stopEmittingSparkParticles();
		if direction:
			velocity.x = move_toward(velocity.x, direction * SPEED, ACC);
		else:
			velocity.x = move_toward(velocity.x, 0, DECC);

## Plays sounds contextually depending on the players movement and inputs.
func handlePlayerMovementSounds(isGrinding: bool):
	var direction = Input.get_axis("MoveLeft", "MoveRight");
	var isPlayerOnFloor = is_on_floor();
	if Input.is_action_just_pressed("Jump") and isPlayerOnFloor:
		playerSounds.playConcreteJumpSound();
	
	if isPlayerOnFloor && !isGrinding:
		playRollLoops(direction);
	elif isPlayerOnFloor:
		playerSounds.playRailGrindLoopWithImpact();
	else:
		stopRollLoops();
	
## Plays either the cruise, or push loop depending on the players movement direction.
func playRollLoops(direction: int):
	if direction == 1:
		playerSounds.stopCruiseLoop(true);
		playerSounds.stopStallLoop(true);
		playerSounds.playPushLoop(true);
	elif direction == -1:
		playerSounds.stopPushLoop(true);
		playerSounds.stopCruiseLoop(true);
		playerSounds.playStallLoop(true);
	else:
		playerSounds.stopPushLoop(true);
		playerSounds.stopStallLoop(true);
		playerSounds.playCruiseLoop(true);

## Stops the cruise, and push audio loops.
func stopRollLoops():
	playerSounds.stopCruiseLoop();
	playerSounds.stopPushLoop();
	playerSounds.stopStallLoop();
	playerSounds.stopRailGrindLoop();

# FOR RAIL GRINDING

## Calculates the grid velocity for the frame. If the player is past the halfway point on the 
## screen, their grid velocity will be lower than the rail's velocity in the opposite direction.
## This makes it look like the player is slowing down as they grind.
func calcGrindVelocity() -> float:
	var baseGrindVelocity = globals.currentBaseSpeed;

	var offsetFromCenter = clamp(transform.origin.x - HALF_SCREEN_WIDTH, 0, HALF_SCREEN_WIDTH);
	var grindVelocityDecrease = (offsetFromCenter / HALF_SCREEN_WIDTH) * MAX_GRIND_VELOCITY_DECREASE_VALUE;

	return baseGrindVelocity - grindVelocityDecrease;
