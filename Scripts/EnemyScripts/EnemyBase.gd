extends Node2D

@onready var globals = get_node("/root/Globals");
@onready var enemySprite = $AnimatedSprite2D;

signal enemy_off_screen();

var movementVector: Vector2;
## true if the enemy has moved off the screen
var isOffScreen: bool = false;

## Must be overridden in all child classes. To be called whenver we want the 
## enemy to die, resets all the important enemy variables and properties.
func resetEnemyPosition():
	pass

## Moves the enemy while it is not off the screen.
## Once it is off the screen emit a signal to the enemy manager.
func _moveEnemy(delta, halfOfSpriteWidth):
	if (isOffScreen):
		return;

	translate(movementVector * delta);
	# don't mark the enemy as off screen until it is past half its width and
	# a few extra pixels to ensure its collider is completely off the screen
	if (transform.origin.x < -(halfOfSpriteWidth + 5)):
		isOffScreen = true;
		emit_signal("enemy_off_screen");
	
## Resets the enemy's position to its starting position and the enemy's speed.
func _resetEnemyPositionAndSpeedVariables(enemyResetPos, enemySpeed):
	isOffScreen = false;
	transform.origin = enemyResetPos;
	movementVector = Vector2(-enemySpeed, 0);
