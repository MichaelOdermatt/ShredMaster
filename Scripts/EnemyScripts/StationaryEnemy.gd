extends "res://Scripts/EnemyScripts/BasicEnemy.gd"

func _ready():
	getFlyingEnemySpeed();
	enemySprite.play("default");

## Call the super function then give the enemy a random altitude.
func resetEnemyPosition():
	super();
	randomize();
	getFlyingEnemySpeed();

## Updates the movementVector variable with the flying enemy speed from globals.
func getFlyingEnemySpeed():
	movementVector = Vector2(-globals.currentBaseSpeed, 0);
