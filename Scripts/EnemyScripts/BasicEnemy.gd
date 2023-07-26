extends Node2D

## Half of the sprites with in pixels
const halfOfSpriteWidth: int = 7

signal enemy_off_screen();

@export var movementSpeed: int;
var movementVector: Vector2;
## true if the enemy has moved off the screen
var isOffScreen: bool;
var enemyStartPos: Vector2;

func _ready():
	movementVector = Vector2(-movementSpeed, 0);
	enemyStartPos = transform.origin;

func _process(delta):
	moveEnemy(delta);

## Moves the enemy while it is not off the screen.
## Once it is off the screen emit a signal to the enemy manger.
func moveEnemy(delta):
	if (isOffScreen):
		return;

	translate(movementVector * delta);
	# don't mark the enemy as off screen until it is past half its width and
	# a few extra pixels to ensure its collider is completely off the screen
	if (transform.origin.x < -(halfOfSpriteWidth + 5)):
		isOffScreen = true;
		emit_signal("enemy_off_screen");
	
## Resets the enemy's position to its starting position
func resetEnemyPosition():
	isOffScreen = false;
	transform.origin = enemyStartPos;