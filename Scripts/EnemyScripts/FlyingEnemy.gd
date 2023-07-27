extends "res://Scripts/EnemyScripts/BasicEnemy.gd"

@export var enemyAltitudeMax: int;
@export var enemyAltitudeMin: int;

## Call the super function then give the enemy a random altitude.
func resetEnemyPosition():
	super();
	randomize();
	transform.origin.y = randi_range(enemyAltitudeMin, enemyAltitudeMax);