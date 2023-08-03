extends "res://Scripts/EnemyScripts/BasicEnemy.gd"

@export var enemyAltitudeMax: int;
@export var enemyAltitudeMin: int;

func _ready():
	movementVector = Vector2(-globals.flyingEnemySpeed, 0);

## Call the super function then give the enemy a random altitude.
func resetEnemyPosition():
	super();
	randomize();
	transform.origin.y = randi_range(enemyAltitudeMin, enemyAltitudeMax);