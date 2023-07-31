extends Node2D

signal player_hit();

@export var basicEnemySpawnIntervalMax: int;
@export var basicEnemySpawnIntervalMin: int;

@export var flyingEnemySpawnIntervalMax: int;
@export var flyingEnemySpawnIntervalMin: int;

@onready var basicEnemy = $BasicEnemy;
## Timer used to create a delay between the time the basic enemy leaves the 
## screen and when it re-appears
@onready var basicEnemyTimer = $BasicEnemy/Timer;
@onready var basicEnemyArea = $BasicEnemy/Area2D;

@onready var flyingEnemy = $FlyingEnemy;
## Timer used to create a delay between the time the basic enemy leaves the 
## screen and when it re-appears
@onready var flyingEnemyTimer = $FlyingEnemy/Timer;
@onready var flyingEnemyArea = $FlyingEnemy/Area2D;

func _ready():
	# setup funcs for the basic enemy
	basicEnemy.enemy_off_screen.connect(
		func(): enemyOffScreen(basicEnemyTimer, basicEnemySpawnIntervalMin, basicEnemySpawnIntervalMax)
	);
	basicEnemyTimer.timeout.connect(
		func(): resetEnemy(basicEnemy)
	);
	basicEnemyArea.body_entered.connect(_player_hit);

	# setup funcs for the flying enemy
	flyingEnemy.enemy_off_screen.connect(
		func(): enemyOffScreen(flyingEnemyTimer, flyingEnemySpawnIntervalMin, flyingEnemySpawnIntervalMax)
	);
	flyingEnemyTimer.timeout.connect(
		func(): resetEnemy(flyingEnemy)
	);
	flyingEnemyArea.body_entered.connect(_player_hit);

## Setup and start a cooldown timer for the enemy's respawn.
func enemyOffScreen(enemyTimer: Timer, spawnIntervalMin: int, spawnIntervalMax: int):
	randomize();
	enemyTimer.wait_time = randi_range(spawnIntervalMin, spawnIntervalMax);
	enemyTimer.start();

## Reset the enemy's position.
func resetEnemy(enemyObject):
	enemyObject.resetEnemyPosition();

func _player_hit(body: Node2D):
	# Since the enemy is only masking the player collision layer we don't need to 
	# worry about checking to make sure the colliding body is actually the player
	emit_signal("player_hit");
