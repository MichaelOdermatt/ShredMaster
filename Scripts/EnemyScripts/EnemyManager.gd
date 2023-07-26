extends Node2D

signal player_hit();

@export var basicEnemySpawnIntervalMax: int;
@export var basicEnemySpawnIntervalMin: int;

@onready var basicEnemy = $BasicEnemy;
## Timer used to create a delay between the time the basic enemy leaves the 
## screen and when it re-appears
@onready var basicEnemyTimer = $BasicEnemy/Timer;
@onready var basicEnemyArea = $BasicEnemy/Area2D;

func _ready():
	basicEnemy.enemy_off_screen.connect(_on_basic_enemy_off_screen);
	basicEnemyArea.body_entered.connect(_player_hit);
	basicEnemyTimer.timeout.connect(_reset_basic_enemy);

func _on_basic_enemy_off_screen():
	randomize();
	basicEnemyTimer.wait_time = randi_range(basicEnemySpawnIntervalMin, basicEnemySpawnIntervalMax);
	basicEnemyTimer.start();

func _reset_basic_enemy():
	basicEnemy.resetEnemyPosition();
	basicEnemyTimer.stop();

func _player_hit(body: Node2D):
	# Since the enemy is only masking the player collision layer we don't need to 
	# work about checking to make sure the colliding body is actually the player
	emit_signal("player_hit");
