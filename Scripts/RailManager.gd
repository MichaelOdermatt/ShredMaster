extends Node2D

# TODO maybe reuse the same code for this and Enemy Manger

@export var basicRailSpawnIntervalMax: int;
@export var basicRailSpawnIntervalMin: int;

@onready var basicRail = $BasicRail;
@onready var basicRailTimer = $BasicRail/Timer;

func _ready():
	print_debug('ready function has run')
	# setup funcs for the basic rail
	basicRail.rail_off_screen.connect(
		func(): railOffScreen(basicRailTimer, basicRailSpawnIntervalMin, basicRailSpawnIntervalMax)
	);
	basicRailTimer.timeout.connect(
		func(): resetRail(basicRail)
	);

## Setup and start a cooldown timer for the rails's respawn.
func railOffScreen(railTimer: Timer, spawnIntervalMin: int, spawnIntervalMax: int):
	print_debug('rail is off screen')
	randomize();
	railTimer.wait_time = randi_range(spawnIntervalMin, spawnIntervalMax);
	railTimer.start();

## Reset the rails's position.
func resetRail(railObject):
	print_debug('rail reset')
	railObject.resetEnemyPosition();