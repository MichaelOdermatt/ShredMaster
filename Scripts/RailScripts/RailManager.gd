extends Node2D

@export var railSpawnIntervalMax: int;
@export var railSpawnIntervalMin: int;

@onready var timer = $Timer;
@onready var basicRail = $BasicRail;
@onready var upRail = $UpRail;
@onready var downRail = $DownRail;
@onready var coinManager = get_node("../CoinManager");

func _ready():
	# setup funcs for the basic rail
	timer.timeout.connect(resetRandomRail);

	basicRail.rail_off_screen.connect(railOffScreen);
	upRail.rail_off_screen.connect(railOffScreen);
	downRail.rail_off_screen.connect(railOffScreen);

	coinManager.monitorCoin(basicRail.getCoin());
	coinManager.monitorCoin(upRail.getCoin());
	coinManager.monitorCoin(downRail.getCoin());

## Setup and start a cooldown timer for the rails's respawn.
func railOffScreen():
	randomize();
	timer.wait_time = randi_range(railSpawnIntervalMin, railSpawnIntervalMax);
	timer.start();

## Resets one of the rails's position.
func resetRandomRail():
	randomize()
	var randomInt = randi_range(0, 2);

	if (randomInt == 0):
		basicRail.resetRailPosition();
	elif (randomInt == 1):
		upRail.resetRailPosition();
	else:
		downRail.resetRailPosition();
