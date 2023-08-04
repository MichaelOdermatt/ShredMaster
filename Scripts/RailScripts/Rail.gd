extends CharacterBody2D

const halfOfSpriteWidth: int = 64
const enemyResetPos: Vector2 = Vector2(192, 112);

@onready var globals = get_node("/root/Globals");

signal rail_off_screen();

@export var railAltitudeMax: int;
@export var railAltitudeMin: int;

var movementVector: Vector2;
## true if the rail has moved off the screen
var isOffScreen: bool = false;

func _ready():
	getRailSpeed();

func _physics_process(delta):
	moveRail();

## Moves the rail while it is not off the screen.
## Once it is off the screen emit a signal to the rail manager.
func moveRail():
	if (isOffScreen):
		return;

	velocity = movementVector;
	move_and_slide()

	# don't mark the enemy as off screen until it is past half its width and
	# a few extra pixels to ensure its collider is completely off the screen
	if (transform.origin.x < -(halfOfSpriteWidth + 5)):
		isOffScreen = true;
		emit_signal("rail_off_screen");
	
## Resets the enemy's position to its starting position
func resetEnemyPosition():
	isOffScreen = false;
	transform.origin = enemyResetPos;
	randomize();
	transform.origin.y = randi_range(railAltitudeMin, railAltitudeMax);
	getRailSpeed();

## Updates the movementVector variable with the rail speed from globals.
func getRailSpeed():
	movementVector = Vector2(-globals.railSpeed, 0);

## Function which returns the script's type as a string.
func get_type():
	return "Rail";
