extends CharacterBody2D

# TODO maybe reuse the same code for this and basic enemy

const halfOfSpriteWidth: int = 64
const enemyResetPos: Vector2 = Vector2(192, 112);

signal rail_off_screen();

@export var railAltitudeMax: int;
@export var railAltitudeMin: int;
@export var movementSpeed: int;

var movementVector: Vector2;
## true if the rail has moved off the screen
var isOffScreen: bool = true;

func _ready():
	movementVector = Vector2(-movementSpeed, 0);

func _physics_process(delta):
	moveRail(delta);

## Moves the rail while it is not off the screen.
## Once it is off the screen emit a signal to the rail manager.
func moveRail(delta):
	if (isOffScreen):
		return;

	velocity.x = -movementSpeed;
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
