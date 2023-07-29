extends CharacterBody2D

# TODO maybe reuse the same code for this and basic enemy

const halfOfSpriteWidth: int = 64
const enemyResetPos: Vector2 = Vector2(192, 112);

@onready var globals = get_node("/root/Globals");

signal rail_off_screen();

@export var railAltitudeMax: int;
@export var railAltitudeMin: int;

var movementVector: Vector2;
## true if the rail has moved off the screen
var isOffScreen: bool = true;

func _ready():
	movementVector = Vector2(-globals.RAIL_SPEED, 0);

func _physics_process(delta):
	moveRail(delta);

## Moves the rail while it is not off the screen.
## Once it is off the screen emit a signal to the rail manager.
func moveRail(delta):
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
