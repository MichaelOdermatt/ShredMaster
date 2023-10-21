extends Node2D

const SPEED_INCREASE_RATE = 3;
const SPAWN_INTERVAL_DECREASE_RATE = 1;

@onready var globals = get_node("/root/Globals");
@onready var timer = $Timer;

var counter: float = 0;

func _ready():
	timer.timeout.connect(increaseSpeeds);

func increaseSpeeds():
	globals.currentBaseSpeed = clamp(
		globals.currentBaseSpeed + SPEED_INCREASE_RATE, 
		globals.MIN_BASE_SPEED, 
		globals.MAX_BASE_SPEED
	);
	globals.basicEnemySpeed = clamp(
		globals.basicEnemySpeed + SPEED_INCREASE_RATE, 
		globals.MIN_BASIC_ENEMY_SPEED, 
		globals.MAX_BASIC_ENEMY_SPEED
	);
	globals.flyingEnemySpeed = clamp(
		globals.flyingEnemySpeed + SPEED_INCREASE_RATE, 
		globals.MIN_FLYING_ENEMY_SPEED, 
		globals.MAX_FLYING_ENEMY_SPEED
	);

func increaseSpawnIntervals():
	## Basic Enemy

	globals.basicEnemySpawnInterval.x = clamp(
		globals.basicEnemySpawnInterval.x - SPAWN_INTERVAL_DECREASE_RATE,
		globals.MIN_BASIC_ENEMY_SPAWN_INTERVAL.x,
		globals.MAX_BASIC_ENEMY_SPAWN_INTERVAL.x,
	);
	globals.basicEnemySpawnInterval.y = clamp(
		globals.basicEnemySpawnInterval.y - SPAWN_INTERVAL_DECREASE_RATE,
		globals.MIN_BASIC_ENEMY_SPAWN_INTERVAL.y,
		globals.MAX_BASIC_ENEMY_SPAWN_INTERVAL.y,
	);

	## Stationary Enemy

	globals.stationaryEnemySpawnInterval.x = clamp(
		globals.stationaryEnemySpawnInterval.x - SPAWN_INTERVAL_DECREASE_RATE,
		globals.MIN_STATIONARY_ENEMY_SPAWN_INTERVAL.x,
		globals.MAX_STATIONARY_ENEMY_SPAWN_INTERVAL.x,
	);
	globals.stationaryEnemySpawnInterval.y = clamp(
		globals.stationaryEnemySpawnInterval.y - SPAWN_INTERVAL_DECREASE_RATE,
		globals.MIN_STATIONARY_ENEMY_SPAWN_INTERVAL.y,
		globals.MAX_STATIONARY_ENEMY_SPAWN_INTERVAL.y,
	);

	## Flying Enemy

	globals.flyingEnemySpawnInterval.x = clamp(
		globals.flyingEnemySpawnInterval.x - SPAWN_INTERVAL_DECREASE_RATE,
		globals.MIN_FLYING_ENEMY_SPAWN_INTERVAL.x,
		globals.MAX_FLYING_ENEMY_SPAWN_INTERVAL.x,
	);
	globals.flyingEnemySpawnInterval.y = clamp(
		globals.flyingEnemySpawnInterval.y - SPAWN_INTERVAL_DECREASE_RATE,
		globals.MIN_FLYING_ENEMY_SPAWN_INTERVAL.y,
		globals.MAX_FLYING_ENEMY_SPAWN_INTERVAL.y,
	);

## Resets all progress values.
func resetAllValues():
	## Speed values
	globals.currentBaseSpeed = globals.MIN_BASE_SPEED;
	globals.basicEnemySpeed = globals.MIN_BASIC_ENEMY_SPEED;
	globals.flyingEnemySpeed = globals.MIN_FLYING_ENEMY_SPEED;

	## Spawn Intervals 
	globals.basicEnemySpawnInterval = globals.MAX_BASIC_ENEMY_SPAWN_INTERVAL;
	globals.stationaryEnemySpawnInterval = globals.MAX_STATIONARY_ENEMY_SPAWN_INTERVAL;
	globals.flyingEnemySpawnInterval = globals.MAX_FLYING_ENEMY_SPAWN_INTERVAL;
