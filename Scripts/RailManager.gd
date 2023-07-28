extends Node2D

# TODO maybe reuse the same code for this and Enemy Manger

signal player_on_rail();
signal player_off_rail();

@export var basicRailSpawnIntervalMax: int;
@export var basicRailSpawnIntervalMin: int;

@onready var basicRail = $BasicRail;
@onready var basicRailTimer = $BasicRail/Timer;
# TODO not sure If using area 2d and passing signals around is the best approach since
# Im not sure if the signals would be fired in time with the _physics_process function
# plus it clutters railManager and the player script a bit
@onready var basicRailPlayerCollissionArea = $BasicRail/Area2D;

func _ready():
	# setup funcs for the basic rail
	basicRail.rail_off_screen.connect(
		func(): railOffScreen(basicRailTimer, basicRailSpawnIntervalMin, basicRailSpawnIntervalMax)
	);
	basicRailTimer.timeout.connect(
		func(): resetRail(basicRail)
	);
	basicRailPlayerCollissionArea.body_entered.connect(
		func(body: Node2D): emit_signal("player_on_rail")
	);
	basicRailPlayerCollissionArea.body_exited.connect(
		func(body: Node2D): emit_signal("player_off_rail")
	);

## Setup and start a cooldown timer for the rails's respawn.
func railOffScreen(railTimer: Timer, spawnIntervalMin: int, spawnIntervalMax: int):
	randomize();
	railTimer.wait_time = randi_range(spawnIntervalMin, spawnIntervalMax);
	railTimer.start();

## Reset the rails's position.
func resetRail(railObject):
	railObject.resetEnemyPosition();
